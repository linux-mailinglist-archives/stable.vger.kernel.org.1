Return-Path: <stable+bounces-268038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AkJqC6P+Omr0NwgAu9opvQ
	(envelope-from <stable+bounces-268038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 23:46:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC086BA4B2
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 23:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b="Xhkbxq6/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268038-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268038-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D8263029753
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C83B27F1;
	Tue, 23 Jun 2026 21:46:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29C3B19C6;
	Tue, 23 Jun 2026 21:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251164; cv=none; b=ryP7wIfxfbvvwX2bks3SH0vDmHPSuvq0GQprUfgSy19zyHXyl82XEmuB0SbK11xVRQmgyQy6uVbNGUsox8LdqaVySsVQb4UUKoqCtExd971ZmU30FcQQR6nEwWTVml2MCcRnLcPX3fw+kMi6BVCYRqjaNWHXhdKqlzVwOWiB2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251164; c=relaxed/simple;
	bh=3o1t823XiZOpGkG4a27ManJW80DNA65DFuZij95W5P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7mTs0H0RLSvqvhBgB92YsLmyzvXZOyxowHkLVvp9iHJ16qO+5J1kxEsYYcBLPTshN6xM1FAF57e4pSWyR+sYzgQPKIkutPc4AZVFJGjTi1sugx4hTh0+EXkycZJoGl062Q7IqhaecF6T9Ue0j8DEOV1QsT2JtTmJVa/NFxdlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xhkbxq6/; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 470EF40E01D2;
	Tue, 23 Jun 2026 21:36:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AcxVn12_ZpDG; Tue, 23 Jun 2026 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782250567; bh=f9wksasLaj0LsaFCbWF9Nbkga8UwYmt9kSP+cjTA6eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xhkbxq6/6NDf/vN+wUfBzYF0VefyP1MdKKa8TN4g+Md3S6SoY8UqWikyQoGXdIsjp
	 tyn0+BGTym3sDHniF6o9D/JwtDNQJqXA2E0w3yE+W3HAu+sNMiL4iFRZPWU85ozjJI
	 HzuqQewvQgOldimvdjdsmRFq+W+cxvZ/KbJlSj7xfz9vjEWPk4mDg0xEKvba/o8Ovh
	 3DEHeGBnET62w2rO0H81Yz7u8QfrrmlGxX6B83r/cAvebglvYp8QyIC3ovWK6AdSMr
	 z3mfyKHAZ2Y/TReYggClPXbxJSPc8BnztVT9oKINVpEeCIemKVm8EALXIvcFsrF7Vk
	 T//DxT7Py266a/Wh4c8WvVG3Ri5gdy+/TAbsijmVe9WkCLNUvx34+pMZt3K3kmsiJI
	 yV9bBJfnLXah/ShtKlio1fDLbQIXn2EaUqbJqOPw1T+Fz9QKZYOhfNr+oiFCATiyzl
	 ObgQeJDlPCSq595+2bx6shxq/3gsjsUaMvZgcAAsMcPGy9xcsQSXFrisiDleG59hUz
	 NSmEX7St7lv/cxvq1Ob1KghSZ4IR61D5m384Eer+X3cwLr4aX84HYbIE3u24PNY02N
	 aX6RYQETMu8WU53UNsIzIFT0p6l4dBzjIUgwT9AuHy5dIxl8rRYiBdpF2NSTRjAxkl
	 mx5vcKU/LXvifxrsta6/Wsx8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0332440E01B4;
	Tue, 23 Jun 2026 21:35:55 +0000 (UTC)
Date: Tue, 23 Jun 2026 14:35:52 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Message-ID: <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623211904.3674-1-jason.andryuk@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268038-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jason.andryuk@amd.com,m:mario.limonciello@amd.com,m:yazen.ghannam@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:penny.zheng@amd.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,alien8.de:dkim,alien8.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fat_crate.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DC086BA4B2

On Tue, Jun 23, 2026 at 05:19:03PM -0400, Jason Andryuk wrote:
> Xen synthesizes the CPU topology, so the num_nodes and num_roots values
> may be surprising for amd_smn_init().  Specifically:
> 
>     roots_per_node = num_roots / num_nodes;
> 
> may results in roots_per_node == 0 which leads to divide by zero in
> 
>     count % roots_per_node
> 
> As an example, I have a system with a Xen PVH dom0 that reports:
> Found 1 AMD root devices
> Found 2 AMD nodes
> 
> Ensure roots_per_node is at least 1 to avoid the divide by zero errors.
> num_nodes are allocated for amd_roots, so roots_per_node = 1 will
> populate all the entries.
> 
> Also add a pr_debug() for the number of nodes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> This is an alternative to
> https://lore.kernel.org/xen-devel/20260506055528.476493-2-penny.zheng@amd.com/
> but it leaves smn available for dom0.

Does this alternative work too?

https://lore.kernel.org/r/20260605230949.GBaiNXPZ2ztjVL7DBg@fat_crate.local

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

