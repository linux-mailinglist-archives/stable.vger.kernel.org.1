Return-Path: <stable+bounces-233925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OtGE4Bk1mnIEwgAu9opvQ
	(envelope-from <stable+bounces-233925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:21:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD453BD98D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CB0430146AA
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D33D1CC5;
	Wed,  8 Apr 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSU77/8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37A3CEB85
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658107; cv=none; b=JyWWFWwYYqY8R0VCyRMqOXMmlfHMgAEf0Sz5cYd6IOkLo41tdGNKe02rjnNcDAAee5qRvSFyyhbAd9Vvu/L0O+P3KtMOjL2c9pui5LkEILJdaC922xOfLJIgcH9RYd2s+NtXfRIaHVRQBy+7sg5Er7nCuRbpH5XFhrU4JBWVbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658107; c=relaxed/simple;
	bh=YWw5Y7n7Ugicw2fILsW6jxyZ2TWfGe7ArrBz/JPwNFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxV9UWtrV72GusGempzBM221ARunT4WfJSNA7QAL0ULrfRCKZzuwczgi0zbFavvWZ/55vq3El8r8ve0ZzWAkW2kqrk+Rd68qwVYgQrOUqyXrCiu2SU94H95B6rJ7PiB/TotSsxn0roROksQ51j7xCtKdD1qPq7QlnSg6xU97o8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSU77/8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB4AC19421;
	Wed,  8 Apr 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775658107;
	bh=YWw5Y7n7Ugicw2fILsW6jxyZ2TWfGe7ArrBz/JPwNFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSU77/8FIDXaVtElITHWBIXN4Nj65Ip+Aq0wvc5I6ucIl9AEO592NtBVGK93qhrWi
	 oYGFClHIgssntjHDXnZWY2sR5UlwK3I/c8mkuZXqo8uLUY56QTwaZnEZzOxY+NYC2u
	 MuarQ2Glg0bQFJ8jDNlzGE8qKsC4ga5KUpCnL/FNsx28+NXQugUpDQ1H3Grht0a54a
	 oSQ8gvRdEkR92TyOGk1M66Ud7KmPxWKj0CHN3+J0f/r4o8XuuEeao42YiLYBv3p/id
	 rmB34DczDp6cMcMIYp8uXDt4v0WylNH18z4pFaaUE1Sqt8kQBcwYqmJ1Pd3v5BhEGF
	 0BiWk8KPjfIYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xingjing Deng <micro6947@gmail.com>,
	Xingjing Deng <xjdeng@buaa.edu.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
Date: Wed,  8 Apr 2026 10:21:44 -0400
Message-ID: <20260408142144.1124899-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040853-keg-enchanted-fd3d@gregkh>
References: <2026040853-keg-enchanted-fd3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,buaa.edu.cn,oss.qualcomm.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233925-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,buaa.edu.cn:email,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Queue-Id: BDD453BD98D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xingjing Deng <micro6947@gmail.com>

[ Upstream commit 6a502776f4a4f80fb839b22f12aeaf0267fca344 ]

In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
reserved memory to the configured VMIDs, but its return value was not checked.

Fail the probe if the SCM call fails to avoid continuing with an
unexpected/incorrect memory permission configuration.

This issue was found by an in-house analysis workflow that extracts AST-based
information and runs static checks, with LLM assistance for triage, and was
confirmed by manual code review.
No hardware testing was performed.

Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access to the DSP")
Cc: stable@vger.kernel.org # 6.11-rc1
Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://patch.msgid.link/20260131065539.2124047-1-xjdeng@buaa.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted qcom_scm_assign_mem() error check to use fdev_error label and rmem-based memory API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d6c55c338b062..d3d4d50fb0e54 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2345,8 +2345,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 		src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-		qcom_scm_assign_mem(rmem->base, rmem->size, &src_perms,
+		err = qcom_scm_assign_mem(rmem->base, rmem->size, &src_perms,
 				    data->vmperms, data->vmcount);
+		if (err)
+			goto fdev_error;
 
 	}
 
-- 
2.53.0


