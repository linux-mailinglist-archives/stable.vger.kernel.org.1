Return-Path: <stable+bounces-219438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALg5IhCfnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:04:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA04192E32
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB1931105C9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7B3148C2;
	Wed, 25 Feb 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0iGgikN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8F30F555;
	Wed, 25 Feb 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002715; cv=none; b=ucVg8mlK7IBnE8ZM27uIAJL6rSt/5QYkCPP/4JqaoVH8Pggb+ovjVNuLjzCt6cKyarTBAlISwIj+/CZCVroAOc0uey6gx9ZiQhrF/A48qjurtUKL4kI1sssSEuaug/PRb93ZhUrmWMYnKhpEBW2qU3RTmAAROyX6KAjwUFIMbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002715; c=relaxed/simple;
	bh=V3N/rVgqOl4pX6Aip+FNyW/bzPqd4nCOwY8N4EKwclk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHW133pb+QhFW6z4iQXuB9BDnrirjk1S5eCXxe0JEpqg1qv2wcNcSboL19Och157FtPYX4mYPHGovWTrqKyAGyNruLtXCzoFH8acGyLqiedtJ6UjcfrjY/H/OITCDMAGQoXveonZ8aRfH2LtBlFp0r0owMXddbdI6MX8C4pY3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0iGgikN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C803C116D0;
	Wed, 25 Feb 2026 06:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002715;
	bh=V3N/rVgqOl4pX6Aip+FNyW/bzPqd4nCOwY8N4EKwclk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0iGgikNDZi0SIFTeBZJpM49PfcoJNV8T5J82UVf6Y2uWEIftgZ1CXHEshq+MWeMV
	 L1s0jKns9sBFGTI7X2F3q49aRGMO+DowYrK5QJFPSa+rC7TV9XxkMt0h+FIZ1BFFiW
	 op9jG4AJeHnw6iPIc11hzxadhaCQfATzz34FsylM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pin-yen Lin <treapking@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 523/641] selftests: netconsole: Increase port listening timeout
Date: Tue, 24 Feb 2026 17:24:09 -0800
Message-ID: <20260225012401.201575230@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219438-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EA04192E32
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pin-yen Lin <treapking@google.com>

[ Upstream commit a68a9bd086c2822d0c629443bd16ad1317afe501 ]

wait_for_port() can wait up to 2 seconds with the sleep and the polling
in wait_local_port_listen() combined. So, in netcons_basic.sh, the socat
process could die before the test writes to the netconsole.

Increase the timeout to 3 seconds to make netcons_basic.sh pass
consistently.

Fixes: 3dc6c76391cb ("selftests: net: Add IPv6 support to netconsole basic tests")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260210005939.3230550-1-treapking@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index ae8abff4be409..64d3941576d5d 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -247,8 +247,8 @@ function listen_port_and_save_to() {
 		SOCAT_MODE="UDP6-LISTEN"
 	fi
 
-	# Just wait for 2 seconds
-	timeout 2 ip netns exec "${NAMESPACE}" \
+	# Just wait for 3 seconds
+	timeout 3 ip netns exec "${NAMESPACE}" \
 		socat "${SOCAT_MODE}":"${PORT}",fork "${OUTPUT}" 2> /dev/null
 }
 
-- 
2.51.0




