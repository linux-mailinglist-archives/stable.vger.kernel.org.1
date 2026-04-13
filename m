Return-Path: <stable+bounces-237587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPadCMoj3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:11:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42C3F0F21
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5EDD3043930
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831833372A;
	Mon, 13 Apr 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z5K2TmgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6731354F;
	Mon, 13 Apr 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099842; cv=none; b=KtVGx41Zt+6HJCaJoNI9d3TeCztVZE9LuTJlYLti3MFLdyfCkkmUVwgdDb6ujF3Iss7PAhAQrtqsDuTyQbLU71lcfVfuK/LVZL5nkTb/jD00MpDY2Qfe/Z9paHg99jiJPbPML7oiou3WQGGptgwGjZVwiyGVc+5zf7Y/AaZxK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099842; c=relaxed/simple;
	bh=s3iO4BnXBdq21pt9BCuizcdZqR/DgYLsAMWOewM7x8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0Jt2lh0///2MjuaSiEXxhtHAC2cVd8QQmpbIq78ER0Q2Vnyekol01E0RBswQ780o3KBBJnPvTSwaJfHmX/YZIsehy5Pe1lNUlYCCoz3dkp4QDGfDEOl9VHWVzqza0S4xIh+Iratooc8Ujlt89nYOPgMKhFnDP2vd5kuGgNumQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z5K2TmgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEABC2BCAF;
	Mon, 13 Apr 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099842;
	bh=s3iO4BnXBdq21pt9BCuizcdZqR/DgYLsAMWOewM7x8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z5K2TmgWHHI14uid425C90asSHCxsJ+MdqOTN+0lh7DbjqURkzrzf9Yof7eITZJqJ
	 qlBcn+jqApwEDBm5ZNRM/sW2BQrpyKyQwM3Vt79n3H1APscZTS+kx4VvdLHh5COeWV
	 2T/ReHr6722QMwaFmFF8jPfuJG1JaWn0Hx72Qrsk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.10 453/491] xen/privcmd: unregister xenstore notifier on module exit
Date: Mon, 13 Apr 2026 18:01:38 +0200
Message-ID: <20260413155835.995440150@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237587-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: BF42C3F0F21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

commit cd7e1fef5a1ca1c4fcd232211962ac2395601636 upstream.

Commit 453b8fb68f36 ("xen/privcmd: restrict usage in
unprivileged domU") added a xenstore notifier to defer setting the
restriction target until Xenstore is ready.

XEN_PRIVCMD can be built as a module, but privcmd_exit() leaves that
notifier behind. Balance the notifier lifecycle by unregistering it on
module exit.

This is harmless even if xenstore was already ready at registration
time and the notifier was never queued on the chain.

Fixes: 453b8fb68f3641fe ("xen/privcmd: restrict usage in unprivileged domU")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260325120246.252899-1-zhaoguohan@kylinos.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/privcmd.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1069,6 +1069,9 @@ static int __init privcmd_init(void)
 
 static void __exit privcmd_exit(void)
 {
+	if (!xen_initial_domain())
+		unregister_xenstore_notifier(&xenstore_notifier);
+
 	misc_deregister(&privcmd_dev);
 	misc_deregister(&xen_privcmdbuf_dev);
 }



