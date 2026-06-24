Return-Path: <stable+bounces-268162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4tJN0zYO2pbeAgAu9opvQ
	(envelope-from <stable+bounces-268162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EC6BE7B8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:14:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=KGG+WJAH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268162-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268162-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940A430F4BB7
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617E3B19D8;
	Wed, 24 Jun 2026 13:10:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BC3B42EC
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 13:10:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306647; cv=none; b=YkZXStrbE1Pm25tXPU7zNNhdLsZ4tWa2ABeb3gw7iQ4Lkayk7Jm0U9I386HE3xQef82G+UgHwVNAWfBOUgNz+8M9vHbxZycbf8wkLykK8s4rK9PFcH2QlKNMgftS6IYjjz2FgM1U1Ea6hVQrR2AAtPuUKcg+bKptLx+JjtAG+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306647; c=relaxed/simple;
	bh=VmZaLlkBLGt0ARVny9+Gp++UE5Ffrwgf6SGkHjK53zc=;
	h=Cc:Content-Type:Mime-Version:In-Reply-To:From:Subject:Date:To:
	 Message-Id:References; b=Lc/h8sdCCBtIsu7tgl60rE11nh1VF8jkEiELA3KVeXICrYpBjT8kvjXnfTaPU8ZN9QtrhIwTBE/9EYjq8c9no6UUX/L6wpQ4dvVTn1RflDQNeexUunYNl+LDojg47tR7Nci7VgTjzAChDwgm0TMUgybC8ZQVTFAIdy4Hm6a6XPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KGG+WJAH; arc=none smtp.client-ip=209.127.230.115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782306637; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zN4T/UVKge7pXSanXH24MPheLLCPtQ+8e1/On+MY1lw=;
 b=KGG+WJAHzIFsY/smaTrWaOIdEIBF1LPPIfckRepsPpLJFsD3lViJj08iDdrblBv7Y3n6hu
 ENsCh2HwFIpEykobF4gkGeXkRwMX10nb1+rqAgB6jkAVvaudX4mY+FZJsYoV8PkNIEieWn
 mVZETjl+WlRBAE99qCK8M0Kl81RZBplMqkM0S4jpElj7D6WClUeylo8bl+SJbMnCZiMTaD
 hEoQC8MO8LrfSkMSaeZIfhpKN/GDkVfEVSjblM0xf5TV3EuLx7zmSSGnVbfO0WNEqD6s4R
 R+yniLsT2g8tXV9j4CndXcMb60tJiHkDdY+mmD9S4WcIYOMSChWa1lrKgt7zNA==
Cc: "Zhu Jia" <zhujia.zj@bytedance.com>, 
	"Zhang Yi" <yi.zhang@huaweicloud.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Andreas Dilger" <adilger.kernel@dilger.ca>, 
	"Baokun Li" <libaokun@linux.alibaba.com>, 
	"Ojaswin Mujoo" <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani" <ritesh.list@gmail.com>, <linux-ext4@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a3bd74b+ada606+vger.kernel.org+zhujia.zj@bytedance.com>
X-Original-From: Zhu Jia <zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <x3jm3mhgsr7zx4hvfgdvmwoqyz5vxx2fjyxy6gs6him46767f6@dkkirnw54x6x>
From: "Zhu Jia" <zhujia.zj@bytedance.com>
Subject: Re: [PATCH] ext4: cancel dirty accounting for folios without buffers
Date: Wed, 24 Jun 2026 21:10:31 +0800
To: "Jan Kara" <jack@suse.cz>
Message-Id: <20260624130549.1-zhujia.zj@bytedance.com>
References: <20260623094947.7853-1-zhujia.zj@bytedance.com> <81ed36cc-b5c8-41cf-8b7d-16611e61e294@huaweicloud.com> <20260624094535.1-zhujia.zj@bytedance.com> <x3jm3mhgsr7zx4hvfgdvmwoqyz5vxx2fjyxy6gs6him46767f6@dkkirnw54x6x>
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268162-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhujia.zj@bytedance.com,m:yi.zhang@huaweicloud.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jack@suse.cz,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,huaweicloud.com,mit.edu,dilger.ca,linux.alibaba.com,linux.ibm.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:dkim,bytedance.com:mid,bytedance.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 340EC6BE7B8

On Wed, Jun 24, 2026 at 02:32:27PM +0200, Jan Kara wrote:
> On Wed 24-06-26 17:52:06, Zhu Jia wrote:
> > The reason I left the tags unchanged in this version is that I was not sure
> > whether it is appropriate for ext4 to open-code xarray tag cleanup directly.
> > 
> > If you think this is the right direction, I can add the helper back and
> > send a v2.
> 
> That was a good judgement! Playing with xarray tags like this in filesystem
> code is certainly not a good thing. For now, I'd leave the xarray tags
> dangling - they will be eventually synced with reality on next writeback
> attempt. If this inconsistency of tags needs to be fixed, the fix belongs
> to the generic code (so that it can be used in other places as well).
> 
> 								Honza

Thanks, makes sense. I'll keep the fix as-is and leave the xarray tags
alone.

Thanks,
Jia

