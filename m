Return-Path: <stable+bounces-71920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F257967859
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814701C20380
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9E17E46E;
	Sun,  1 Sep 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mlCnKuOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978771C68C;
	Sun,  1 Sep 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208254; cv=none; b=Bz0zsuJ3g6nzriMUMucvbsjnpd+/mbHXK8XKmt/Jd5NVedNHy/5kOY9wO+zmaklbF98ixmJNrZTOcF7PCoTRrut4y8v9qzKtvF54o6SU3z7BncpyzDGmawTSW9gAsRorD6L3bh+qbR4fppvtKyf+k1UDOMnJ/MJwNP+7VwPTD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208254; c=relaxed/simple;
	bh=JLUCg03veTVKesQfY3kpelRlY7k+/2XhKQxepfD4fDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iv+VM0ckcOjwTNrphIpH878r8nfpYVZhPMzNR6eYS4AqsfO0S0K4iVw52WOtMwzeIj9WpYyU049L1bq/GvnwKN53n6yIuR5puGSh4hJVSrMKY4Rrgo9cQL+OUe5eXQqUrgiLiRezObJOwvQqDlX8JCZeDU4QtM4SayiUwpHZC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mlCnKuOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077D5C4CEC3;
	Sun,  1 Sep 2024 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208254;
	bh=JLUCg03veTVKesQfY3kpelRlY7k+/2XhKQxepfD4fDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlCnKuOxC7Khr6j36Mkg3BB6PawpNqlDfXEln/zr+SDGKct0aEhlbF24IfQ2PHMaE
	 wluKTTsinyFFUtQkNE3xTKvuFtpgkM9Iv/YffCkbJv1QjVG6Ra9v1KA8fYwaHuTU0N
	 6KbKhKB+mcVmn5L8b1c+xmNJJyQG9ow8CI9sp664=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.10 008/149] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support
Date: Sun,  1 Sep 2024 18:15:19 +0200
Message-ID: <20240901160817.780395041@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Berger <stefanb@linux.ibm.com>

commit 08d08e2e9f0ad1af0044e4747723f66677c35ee9 upstream.

Commit d2add27cf2b8 ("tpm: Add NULL primary creation") introduced
CONFIG_TCG_TPM2_HMAC. When this option is enabled on ppc64 then the
following message appears in the kernel log due to a missing call to
tpm2_sessions_init().

[    2.654549] tpm tpm0: auth session is not active

Add the missing call to tpm2_session_init() to the ibmvtpm driver to
resolve this issue.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index d3989b257f42..1e5b107d1f3b 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		rc = tpm2_get_cc_attrs_tbl(chip);
 		if (rc)
 			goto init_irq_cleanup;
+
+		rc = tpm2_sessions_init(chip);
+		if (rc)
+			goto init_irq_cleanup;
 	}
 
 	return tpm_chip_register(chip);
-- 
2.46.0




