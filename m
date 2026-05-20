Return-Path: <stable+bounces-252682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIffKZkHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-252682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD021597EF8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 981D93286E09
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2E372B31;
	Wed, 20 May 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MoBLteRj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D13D1CC6;
	Wed, 20 May 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301313; cv=none; b=k7UwRltHfIqbCQDVWKjmvpARUMe+dk1P3v5s53jMYe7j92ZV54cjY2/P2Opd0eSuSeJ1o5mwguMeNTEJrhBNrZiwRrELPBlBiuFYIbyn31rqNx8mL0YOjt6VQRZKrpzzT41MGuRzg6O0dP82jJ1tgOn/y68ILrbON/7TQxTynFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301313; c=relaxed/simple;
	bh=klJQDkh4QaQ3UEwCCL1mO1mLQtDWgvaI1AHHoAzWCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnA68TKN3pTjazgD+PC348ZbWcVplomCf1vJi0C4NEYJBNS76xEl4C2wrgChI31z6HwaDbLNeMSA6wy4LfD4Lf2iSGRE/W57lXBa/N6Irml1bnOeOK5UUBeN0joRdFwJOxqZVZxrRsNXkLos4Vz+b7ey1R4B5DtdXKJUMm1g+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MoBLteRj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9471F00893;
	Wed, 20 May 2026 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301312;
	bh=B1rAajSTlimMwgMnmEXybhTNXE64nNERqkslCMR2Ii4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MoBLteRjOI3vDW3CdM59U5mCx0ABwfW4bnUtSMz9TcSV9ztYVNgHgv1Vm5XGc0dz9
	 ROJVRdezQi4R1MDkTHrPg35q5ZTrKgwzcyIEB2CYtWXOTyPuhIHKrXnKCxt6luRgkC
	 fY2snHNoAUsCb/89v/H/FcDQawEJApNlWGGflhG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	cuitao <cuitao@kylinos.cn>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 506/666] cgroup/rdma: fix integer overflow in rdmacg_try_charge()
Date: Wed, 20 May 2026 18:21:57 +0200
Message-ID: <20260520162122.228199025@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252682-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: CD021597EF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: cuitao <cuitao@kylinos.cn>

[ Upstream commit c802f460dd485c1332b5a35e7adcfb2bc22536a2 ]

The expression `rpool->resources[index].usage + 1` is computed in int
arithmetic before being assigned to s64 variable `new`. When usage equals
INT_MAX (the default "max" value), the addition overflows to INT_MIN.
This negative value then passes the `new > max` check incorrectly,
allowing a charge that should be rejected and corrupting usage to
negative.

Fix by casting usage to s64 before the addition so the arithmetic is
done in 64-bit.

Fixes: 39d3e7584a68 ("rdmacg: Added rdma cgroup controller")
Signed-off-by: cuitao <cuitao@kylinos.cn>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index ef5878fb20057..d544a747f3954 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -283,7 +283,7 @@ int rdmacg_try_charge(struct rdma_cgroup **rdmacg,
 			ret = PTR_ERR(rpool);
 			goto err;
 		} else {
-			new = rpool->resources[index].usage + 1;
+			new = (s64)rpool->resources[index].usage + 1;
 			if (new > rpool->resources[index].max) {
 				ret = -EAGAIN;
 				goto err;
-- 
2.53.0




