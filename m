Return-Path: <stable+bounces-263143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lxBDOAOcL2rTDAUAu9opvQ
	(envelope-from <stable+bounces-263143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 08:30:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A1683D43
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 08:30:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=RP7LsnDG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263143-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263143-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC96D3020D6B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 06:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EAC3B1034;
	Mon, 15 Jun 2026 06:28:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24C3B14CB;
	Mon, 15 Jun 2026 06:28:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504893; cv=none; b=cLbSp/8FHwYujxy8ZLwufIlaiYbVC07Aw15ezy/rP3ETfRUB14juyE2RzClzEeBFBdhPkLXil9N+D0572dmCRKS3LOL9Q8zymAM2gZBIm1eCvRYmaHWCZFD4VBNjyumM5AmgWCpENCz7+XIJ/LnbmQ+yT8DMnci82NV9Oy8rfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504893; c=relaxed/simple;
	bh=y6XxhbY60dG0xbY+ie3dpqCXk+DmKuE1kabryxtn0PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTrkyAlqY/jot1JqgyInDVNJBEQUD3enkwYJGL+HpwBGZHh5VPGPRo6UMgW3Djc7ElTqX8JONyH9CoChP+LOE7zm96W8pq8uv3VQc86eomwadYv/oP9v+TWxXBLMhG9wun1ppwhuz53b28WpjBVQnnbcEX23YPrlRneBXDhPJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=RP7LsnDG; arc=none smtp.client-ip=207.46.229.174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=7AY37jUilyOOppCw24yu2Fs6f2pcjFO5/7
	U8o9TKtYo=; b=RP7LsnDGbbIXyVMyb2LI1/zK1HQ2P8NedGTmh85BseubLQ2jwb
	KuCH0QHa/RLCXK8A9vXADyogaMS6fMUMFA7lDJeetVP3lwX/l76FANVU/0bWQ2CA
	+oXOcYr2xhW3tbHXIHF6U7Ym+SzHjMoD+aPYYDz7KG+eGDMOmYaNrr/QA=
Received: from localhost.localdomain (unknown [59.66.142.89])
	by web5 (Coremail) with SMTP id zAQGZQCHQcFsmy9qe1dwAg--.25454S2;
	Mon, 15 Jun 2026 14:27:56 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	fengxw06@126.com,
	horms@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	qli01@tsinghua.edu.cn,
	stable@vger.kernel.org,
	wangao@seu.edu.cn,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] atm: br2684: reject short VC-MUX bridged frames
Date: Mon, 15 Jun 2026 14:27:56 +0800
Message-ID: <20260615062756.31081-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <26ebc58c-6399-4a45-aa55-91a3bf398fef@lunn.ch>
References: <26ebc58c-6399-4a45-aa55-91a3bf398fef@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHQcFsmy9qe1dwAg--.25454S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYJ7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcV
	AFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAF
	wVW8AwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4c8EcI0Ec7
	CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUxeMNUUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQITAWovKbDI+gABs+
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,126.com,kernel.org,vger.kernel.org,redhat.com,tsinghua.edu.cn,seu.edu.cn,mails.tsinghua.edu.cn];
	TAGGED_FROM(0.00)[bounces-263143-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:fengxw06@126.com,m:horms@kernel.org,m:kees@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:qli01@tsinghua.edu.cn,m:stable@vger.kernel.org,m:wangao@seu.edu.cn,m:xuke@tsinghua.edu.cn,m:yangyx22@mails.tsinghua.edu.cn,m:zhaoyz24@mails.tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 367A1683D43

Hi Andrew,

On Sun, Jun 14, 2026 at 08:39:12PM +0800, Andrew Lunn wrote:

> Same questions as for the previous patch. Lots of parallel
> discoveries? What hardware was used, etc.

I'm sorry that in this case no physical ATM/DSL hardware was 
used either. I verified this in QEMU/KVM with a small dummy 
ATM device as in the previous patch. I think that this is a
real logical bug, but whether it can be triggered by a real
Device was not verified.

Yours Sincerely,
Yizhou


