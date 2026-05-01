Return-Path: <stable+bounces-242335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEHrGSeP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:31:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D85054AC099
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70A0F30160D1
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD432EC09F;
	Fri,  1 May 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="JjXhYuza"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CA2F5A06
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635107; cv=none; b=OoAAJ/F9zOQmAMQQwQG3DijHAiN0YZKGTj5YbThE2F6ndtMfJ/5xxgB8/8Z+Z/neHx7o0+4RfJHz4Sq+CxzRQwz0c6LeAWGAQlSeuATnpcPGrETNLu9mmpB3E9+wjGhqzoMu93GFrMoHCFZpTiCvEh0KZ9HF7pE6Ll5HShpUwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635107; c=relaxed/simple;
	bh=AuSVC706Vy6SCCQCljr/JOp55VZODBEf7g8MprH5FcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc0uGP1yva2jVXfL5Rwz/nvcz3nKeCfxnhnrgLltYMBtjby/DHPtdyOR0/fkwatapt3a2Tv1dJKI9IHttlmRCLpqwNEod6wKaFy4gOBb5VLhsf9bplSckGWuot4tywX49aZxXYNQiYXMCRlmGp2YeRwuoAt93LKtaMLQLyPVXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=JjXhYuza; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777635098; x=1778239898; i=deller@gmx.de;
	bh=ikHqYCJoGi2XMHtWJZr0aFZgIK6X2ZTrLR8fCi86HaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JjXhYuzax7755hwqCC0dIxYl7PkXw9+e70sOleIbeeiP05Y/TzgNnPZfxBnXImGF
	 rS8k0dS80k21Fdab+raw98DdyeQLeohysl+MFc5SZbL/EbKWgGdvyzL4ytUplZb3R
	 Di8/aL9fIkLhEHAqTUslL6lUimBUTwKJqXluGmkZhsM3kg5Y6H6CIv7293hS33chh
	 SnDfwP+ZafMWIukZGh3c9qPGPb1YOinI/WdSf8gl9qxBhMM/JHyBUS7UsqPtuRqBA
	 mVMoFoZXgwgDM+YTvN7azSwEE90fafXE5vQoiUccPcq8KidoZG+rylrWh53cKnT+U
	 P7g9Oohpeei3b6/x8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhyc-1w6AuW0M7e-002kC7; Fri, 01
 May 2026 13:31:38 +0200
Message-ID: <ad114140-ac88-415c-beef-c36a1ba4516d@gmx.de>
Date: Fri, 1 May 2026 13:31:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] module.lds.S: Fix modules on 32-bit parisc
 architecture" failed to apply to 7.0-stable tree
To: gregkh@linuxfoundation.org, jpoimboe@kernel.org, petr.pavlu@suse.com,
 samitolvanen@google.com
Cc: stable@vger.kernel.org
References: <2026050157-rewrite-overfeed-ad3b@gregkh>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2026050157-rewrite-overfeed-ad3b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Iy5uF37tLirBVMWRU+3C1+9s7Hm9jzjPt0zibOrERvaXN2RBvn/
 jlwekzJylaIxbv1Dp1ZR+ahoDV4b+VFYdSVJaFhCG0DMzZM7kJLuM8D7/mNSsp7IYv5vcbj
 91u1cvLrlen78YaTgkDlsX6sCqD7zjs0+17HH3cyaaiT0Rvo45Ww8/k8rzWQ6evVljRBfjH
 LAMxPQBiPHfjwgcs+Md2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:otQ5TPVtJII=;/wv/8dsj88jbJ2kadFMT0ycZuKd
 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
 eQX5RQ==
X-Rspamd-Queue-Id: D85054AC099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242335-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	FREEMAIL_FROM(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:dkim,gmx.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]

Hi Greg,

On 5/1/26 13:01, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 7.0-stable tree.
Can you please cherry-pick this upstream commit first:

commit 4afc71bba8b7d7841681e7647ae02f5079aaf28f
Author: Joe Lawrence <joe.lawrence@redhat.com>
     module.lds,codetag: force 0 sh_addr for sections

after that this commit applies cleanly:
commit 1221365f55281349da4f4ba41c05b57cd15f5c28
Author: Helge Deller <deller@gmx.de>
     module.lds.S: Fix modules on 32-bit parisc architecture


Both are relevant for 7.0-stable only. No further downwards porting needed.

Thanks!
Helge

