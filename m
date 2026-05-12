Return-Path: <stable+bounces-245378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGvOGEGLAmrVtwEAu9opvQ
	(envelope-from <stable+bounces-245378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:06:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2709518AAA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41D28301DED1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9232DA76F;
	Tue, 12 May 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VbqDWwwe"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B32DB7A9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551594; cv=none; b=MQskzYkfruIFeWfbPlbk+9qyMKEZxShU39GyqxoCnMpHiGWbkLwCAX6mrIEhjAdqMSR+eMLb78PE0psiv5UCt+aq3jQ6Na6ewzPwI/ZWqtdYldpFKLcnUJ8tmHfOlszEMZUw410I25LScw56YM4uKm3cADRV/9B7F+GAkavchgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551594; c=relaxed/simple;
	bh=RIuefCFKPrv0JQDV6zMwmpxjA934p38aj5atlMN6Caw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDfzgQgx5hPpl1onLKtNBR8yWj3/H/z8hRVqfbR9Evct8/NS3TtvlZZCEAYIUsw2iGWXSgEFMAKhqWXNfJzakTtGLZQuTvgE2cKJYV8WkLMKdqfzr+QJ8S8PumSqT4WYfBRlT6mcVUyp9r03JYlJY0Yo1DV+5qnbANUOuSFta5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VbqDWwwe; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778551547;
	bh=RIuefCFKPrv0JQDV6zMwmpxjA934p38aj5atlMN6Caw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VbqDWwweX2ZoFU3MFABU82K0mNs6gAa/JII13XBdflrMTxy4MSrJ3F3FlpVzJbjM0
	 lJrEeFqd5lxtwpKuQ1qOwgOCKNwsR71iQVoqT6gd12CAx1US2my5Srk2YQhA+5TLUX
	 woM0xRWU8/a5P5LWtLj2c3Vo0B1lqGr02P8kpy0k=
X-QQ-mid: zesmtpip3t1778551530tc7f86e2c
X-QQ-Originating-IP: kgBge4GMdRjXFINEkBLt4uzoSLD/jwBTNmCUJCn3P2U=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 10:05:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2599855699344231170
EX-QQ-RecipientCnt: 15
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	harshit.m.mogalapalli@oracle.com,
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
Date: Tue, 12 May 2026 10:04:11 +0800
Message-Id: <20260512020411.129938-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260511220000.stable-reply-item003@kernel.org>
References: <20260511220000.stable-reply-item003@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mxh1r6NAWu990gNGKz2F3nunQyufNByGGbPiI+t74KXhvElZbU/ext4y
	CiW9IiAACT9aYq3TVy28D1BEN4WROpoLUv2aDaT6Ew+w6asFgfdqtU+HyphqXC90yyt3403
	v3+wJAgYWxbGCNfE3lg/jl9GllHBx3xIwianUH45S6CZzpYCPgR32N0CdMp+8hA50U27U0D
	4gR+/+1JADez1wOO7h3TCO0Zsp2a7oGUjs48p4xQ6qBI6EukylXp32sCwd1kSHNL0/IFXVx
	XJ8Y8Gde+neb6i3oQq3NM6T/q8R9++Yo9qqSDCB6Ua1Smzsi2AkuMmnUngNSkSPcmTQ/WSm
	jJzu7o762dNK8Vp4ClLO6CK4H6hrrOR5IXW7VLuYsro0H1qEXa8y+b07yryCUya3ag8l6Z8
	X1Kbh3Kz4t3KEQ/NGTA+00jTvSBSKQx9XZ2TLUS+stFZS+jawQrub5Fq5KBJjfEfFJFeWoX
	BPxSSYLqVaU7/KTsB2rZV2opuqKhH+iEe+mpWI5gry9ImXCObmw/8kws4bfQLXR8KT1c5H1
	FPPiSJfy5e/7k9FsBpkSDrIW8A+MgHsTPDalCnZrzbSlhsIkCZbOJ5osC3lbttxDdyX5znN
	zclDcBCOy8UAbv+MGiEcWs/ZjXki3IcCC8UtImmgFB6Z1co7dT6KsJfpi3Q9hoiVpOrCrzq
	KgQGv7Hn2M4eLB+8olLkp1gHAKw0aZ4AEjQqb+SAdhvOZhnnRWlzY7by13zCIXJbibem1KP
	uCIK6DMGO7HKnZm/3qBOQYUSeRgrUj1OkzxVcJgK/EEa35O55nk3NyZ2W5upEdwggZN3yfG
	xsAIO1Hp2UPQiy+0Sm9xJ5PYchl1wItOaldgM/cyUxqievnv675fGEuvJriqEJpsJY0p/f+
	TTfr7Fl6mtmXnwjZVVjdUavmiB5AMo5StoWIYR5fclHsMQwfzfYiEcPkPimbyEeQZEveWbH
	qtllG++GJhbSGWW36/oiOw+mLRy7w3IjAUbZcOjIbt2pGAzh0G8ooJDKl5YezohJPViMyMb
	j7uJWIZSBJpX0YLAhFNEaRHgmdDJw8a5zkJ7DoWvQMmiSIQJdAvsARyl0wfrqsJsaPKqJPi
	jvk26U6sx632MxtedrX5Lw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C2709518AAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,linuxfoundation.org,uniontech.com,oracle.com,kernel.org,gmail.com,auristor.com,linux.dev,lists.infradead.org,vger.kernel.org,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245378-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

> Queued for 6.12 (both 1/2 and 2/2), thanks.

> I fixed up the bracket annotation at apply time per Harshit's review:
> the trace event was actually dropped in bf20f46d94f1 ("rxrpc: Fix
> potential UAF after skb_unshare() failure"), not 016725807ce3, so the
> queued changelog references bf20f46d94f1.

Thanks.

BRs
Wentao Guan

