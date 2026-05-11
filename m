Return-Path: <stable+bounces-245158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCnsCemRAWrTeQEAu9opvQ
	(envelope-from <stable+bounces-245158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:23:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182150A05D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2345F302413F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBEA3BA23F;
	Mon, 11 May 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EtzkBjNN"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A733B7752
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487493; cv=none; b=la/byjpuBp3mKfH16bAoCg0GZFETdad3rkOzeMyCGgvR1Wa4EXzbyHOXjpYxdWEVyRZwaW62Hwj5e7tYwmz13dTzVGGHT1SPY2srLf2kBCLkboed5/ebcDl2Ze1x5PGuNAuzxtPwj0bKEmEoiPLbS6BIFOxxmiRfzDXvVFiK/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487493; c=relaxed/simple;
	bh=Ak2TkHolYNU8FLfAolW0An7dtohaOwZFAtJxB4fp7bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOVIjqtlwzcLhtTfGfPg6/p3kS6/ybPt8eiKQf65s6z5DqP6IM0OQTMwXwaR7Fa5mi8vCaFSYRckRlRG9BiVyheZUiYH+o9OuLfF8iYbM8xFTA9ZnloWGnmxhqeydS/BiNVZnyyGtdnWahaoYy4K/C7BynYBesf2U1JP26UId/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EtzkBjNN; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778487463;
	bh=Ak2TkHolYNU8FLfAolW0An7dtohaOwZFAtJxB4fp7bY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EtzkBjNNT6MqWnz+30SLT0UnX9eBXnkvJLRXDYBPY37e5R7HbHr6RvnLoaZ2f3s0B
	 cSDOsrjBtdmTAnii+Joe4JxKgZy8pOUQBCR+xw0mMgGwnrJWNKDOUiwfGdJeE3U8Le
	 JhobXX+HANf8dPIWm1ZsuEJhO02mWCdKvkBw48fY=
X-QQ-mid: zesmtpip3t1778487457t494da95f
X-QQ-Originating-IP: zmgJ3x1ZIlB6iOayDnTVI/8xUra9rLyP+owN1PCastE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 16:17:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2768946232651250011
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: harshit.m.mogalapalli@oracle.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	horms@kernel.org,
	imv4bel@gmail.com,
	jaltman@auristor.com,
	jiayuan.chen@linux.dev,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	stable@kernel.org,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: Re: [PATCH 6.12.y v3 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 16:16:19 +0800
Message-Id: <20260511081619.65091-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a194c1df-8e39-48b9-a8f5-696e32558bad@oracle.com>
References: <a194c1df-8e39-48b9-a8f5-696e32558bad@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M3efC+6bo9V5QuM8bLO6lhyAjj/wiZI222Lq/5Br990AB6q5e2n3v1da
	EsppPJTDZIesgB3HkMbNBbAUvJBUo2Esd2JJ3ixBytuF3e0laIsrlR+6lyDIBn52TLMM4z0
	EK7rk2MJ5r5NvOGkRuQCwy+Wf0VMIiOCVsQLYMK8JKbaELh4hJ33oGHjZ9QQdzdOu6EITSN
	J64PBmiTHQt57/eBLz+MGEs/SxlDdMU8tuPWJpsSX38131FZyg9/UWQj3vuKo2AUOmdMUu5
	JzcoIobv9SACqIsP0RVBeufsHNzYSxXPdWHBAnOtJv9u99HWn55LjxwZcCH0+LRCRMC+5La
	TZwvUP/5Si2uU4IgiGdbN/aHhyro8aGXofHWmebCaNF/MarnxpRdyn+caDOBKEfWZ6S9aeQ
	4Kcu9z4GgZDclje5BnmAYepXMJeM19xQjtZqsjMTODE8vIThaADGeseoB7S6muLbQI9pQ6d
	L2dWKG1IMZGUrx5Ekh55LjJY+DQIc+ng1JjfmP5xY6Ic0m7OW++Zi7QQGZzUVmWaQkfGLRx
	QQDUDxyKnmenpfr9CMV5zzofUymGeZDIovvapveChNXsya/0Uu7fO2xbxgJTmKo8Vgfq/I5
	l5OxhX3QdQyTiY3g0wSri9MD/E2067+Cy4/lCgG16MN9QZ67D+qXX/hukkO8zM0weA1M/LQ
	XK5q7mLgzZATxDAyfhP2qVJa0M5bnijVxjtahEnG14nTmIJ+53Sm+Ip0juuQqyfKcApij3r
	UXCartWMdHx1C/1kJNwcnSgyd1qHwJ04QAmwJ9pBvDav/mYITt+A+0RUiO5IqP8rSRgVjcP
	DwP8S/p6mJ5/orBeIF1yGMQcLrBIieE4E+PeFX+MdDA6q4ix9sB4YDRovuOTUNqO6ODidcE
	5laDudwJYtUAbwdTcSA0jZsRjdQAYpyQ0Vcmeyf6cH8h6aXHSZ3A0tYCotJ1uHjVQIoEeCe
	CJkSigL986J4Y9PoWVFKQYSTHJorl6RTymYgjAjJiuu7XOPnf1q/Q7N+a6PlBFUf4GpBzOG
	dZFzAJno11X9CWpWvDBJR9g4hBUxGdtwBIyp9F6SnQYfSK7aU6Zb8cb1KptyYTq3RofSInf
	fT3rAtt6c9DPQzCA2lWlhC0gJ2OZnZBeyeWXK5tW4l+4fl0eyqH4Ae9J4dMHnGQH2adq2fO
	HK1oTjO6OLvxeolu0nxs1oDg0l183OmZcsvR
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 3182150A05D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,linuxfoundation.org,uniontech.com,kernel.org,gmail.com,auristor.com,linux.dev,lists.infradead.org,vger.kernel.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245158-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

> On 11/05/26 13:11, Wentao Guan wrote:
> > [Readd rxrpc_skb_put_response_copy which missed in 016725807ce3 in v6.12.86]
> > Stable-dep-of: aa54b1d27fe0 ("rxrpc: Also unshare DATA/RESPONSE packets when
> > paged frags are present")

> Yes, I noticed this too.
Well

> But you got the commit wrong I think: (you probably meant)
Thanks, i paste wrong commit here, which i reported in
https://lore.kernel.org/stable/20260508083142.1752208-1-guanwentao@uniontech.com/
SUMMARY:
commit ("rxrpc: Fix potential UAF after skb_unshare() failure"):
bf20f46d94f1db38e6ffc0ca204a5fe0de01b495 v6.12
1f2740150f904bfa60e4bad74d65add3ccb5e7f8 upstream
is different

> Hence Wentao needs to add rxrpc_skb_put_response_copy() in this backport.
Yeah.

BRs
Wentao Guan

