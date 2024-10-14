Return-Path: <stable+bounces-84825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37899D241
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE0C1C23643
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149AF3A1B6;
	Mon, 14 Oct 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kJjg0NrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D851AB538;
	Mon, 14 Oct 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919338; cv=none; b=Oxgw5CDM2UwSn7UY+JuQxaO2BFumTLAzDJOigz/81ZD2hPTnrQyOMgAJ7W/+2MH1GGp/Sk/VsZww6zEYYu4fhgxdZkwv9ggLt49O+fDdZJ9ezDV6IGoFRFomENAO1qnAXYPJuN2nVJF7x/gTcOjO0jjXgPtxS407BYnJwqnoyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919338; c=relaxed/simple;
	bh=wvFTNvtLTDmlw3v9sz4SndhmyD2vSnxQ2wRJVPm9BUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpnizK0ZWnm3z/7vMV5bv6I0wUHp/4C8avSJHCIQqqxrB5xkWN7SM5O1V61uiqkqYsUyniaWCJqLqvzjALymHcmALj1o9G7f+9QSv720Y7Tp5maY1Ry+utBbfKcIPnEoR+93NFNREuenJxd2UHSkURevsfyA79OTLSEffeVaHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kJjg0NrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34747C4CEC7;
	Mon, 14 Oct 2024 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919338;
	bh=wvFTNvtLTDmlw3v9sz4SndhmyD2vSnxQ2wRJVPm9BUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJjg0NrQH5umlNqgBxgb8/xIT4QXUZ9SfkJOSA2t4rVrfCPRfaUnDfHnNEeWBPfGU
	 5VieNWztkJgh80aPhhH+yUYkmUUtkRupczxXFLESz5DNnObtXRG62zqdO3WFRJP+gN
	 s4xDrOkqXaEp/br/3vQsxNY/AlgYuXsOO2ZSbyEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 564/798] jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
Date: Mon, 14 Oct 2024 16:18:38 +0200
Message-ID: <20241014141240.155773989@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit f0e3c14802515f60a47e6ef347ea59c2733402aa upstream.

Use tid_geq to compare tids to work over sequence number wraps.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20240801013815.2393869-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/journal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -737,7 +737,7 @@ int jbd2_fc_begin_commit(journal_t *jour
 		return -EINVAL;
 
 	write_lock(&journal->j_state_lock);
-	if (tid <= journal->j_commit_sequence) {
+	if (tid_geq(journal->j_commit_sequence, tid)) {
 		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
 	}



