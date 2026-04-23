Return-Path: <stable+bounces-240475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJNcKV0I6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:54:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B43451869
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 875A2303DF78
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAE3EB811;
	Thu, 23 Apr 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZNPkaSmK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkuHUu+U"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC33EAC6C;
	Thu, 23 Apr 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945205; cv=none; b=lI/1OAPjMUCOFCHiznupeipGFOABAEnhUL88OouhzoVnS+m1LHoHH9EyvpwOdfq7zWvZ3r7O2JI7PmnppwQ2mJSnJaIDfeAv4Jf5GyIlzUHcj1j+fuuUCXgwOJhewUZ+2CUMZGk+5f5SNI6BZtED7E+rMrG5WhgLZa7EAPzf90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945205; c=relaxed/simple;
	bh=UhudvESgZDiPFof78t+VtEW0b66cNfY/0VMg6PI/KhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4aMencvNpguvE9+nKm4fKvhYwOnGGyzVS0yvHgppjAsO0VzonEPCa97Rd1WMF7xjghd5Ce4aT2OQKvoTKlBZKtJU0JX0YZlHEwahenFL/FTFNur8KcTq+Ui3QblF4yZcoBrMcQ0aX2EOvqCdFW3YFwInd7G9bJ3jag6EiqoGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZNPkaSmK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkuHUu+U; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BC351D001A8;
	Thu, 23 Apr 2026 07:53:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 07:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776945201; x=1777031601; bh=uag7GGbk73
	yl+XuWo9HkmK1iD4wAxGe8aDwoAoVruSE=; b=ZNPkaSmK/s+ugS9fowx6nd0QOY
	Y5jiCveIZT7CbnIqtWf96Ju8dsz5ihozAazm9MKC0W5Mo/q8xz+XKm/wiSlIa3+u
	IgYwnE6eLumnCwb8c6+diAiA5/INXPjckLiHO35rlTVjTWE5jDv+YIYBgnZbXUwW
	BmMK2NvGwQMo3JoWzXB2xizl4rox4fom5t7bsXykS+84fUkrqqf/T17+sRrVdXLX
	wsAPM/AknhWQZRwCf1FlLydh1Rv6nknO2fyLm+dsxl4h0DHt6MD3gz+ULIhm+oeo
	JsYxFTu+US4GlurpCa8QuVhUGHVLwp8QTRiHN/RKOiyoH62lmAnyWnDttreg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776945201; x=1777031601; bh=uag7GGbk73yl+XuWo9HkmK1iD4wAxGe8aDw
	oAoVruSE=; b=OkuHUu+Uh7VjDGNbOWy/y+22xNCOfu6oLMJDMp7pay6QQvbUgZ6
	labbcOGN/k/B33rTH1QfJba/tilcISnZtpaSSrjMcHCGXn8CIkpkthEp2REcCI9d
	cZlaGsXwl5k8Jjiw3diMrEVMWeaDMuDCX0bjarjdpyIKrPHmQeSookisJWj9NRhz
	dDxgl7VC7QjzVkFL21lzk0r/5np+qwxpTwp6HUNyTagF87irVU4MK5Xkvtx8qljh
	y7wjOBPZdTQHpVVwF6YNqzY3uAyGAmZr2YgZ9AFjmiZbEB0EwcEUlEM/+xzH1W31
	8Dlju6J0DDL6q1NuYGX01torX5bfGUKZjRA==
X-ME-Sender: <xms:MAjqaej8UelStiuZ6hT5Qb4Kp_lLBZrkOls_aUrxk0OzKolcekp2uQ>
    <xme:MAjqaa_dRaA6FlEMNiLPECcT7W90A1SBpF6grr5ppSCjntxXfLYGGGMioCSyw-H6C
    GY_eDL3-Zw6Y7YyQh5rJt-JFLMutc3HzMhxbTRCaHgXVz20wg>
X-ME-Received: <xmr:MAjqacM5IOXxdeKcObulH-JNQV7WLucAfwBitnB7dHmm8zbrNZYmxOPckBcjBzUk6tNOJORNTKFgDfRdOE751Lvl7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtd
    eufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuddtudeifeefuddtheelsehqqhdrtghomhdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmrghrkhesfhgrshhhvghhrdgtohhmpdhrtghpthhtohepjhhlsggvtgesvghvihhl
    phhlrghnrdhorhhgpdhrtghpthhtohepjhhoshgvphhhrdhqiheslhhinhhugidrrghlih
    gsrggsrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehshiiikhgrlhhlvghrqdgsuhhgshesghhooh
    hglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepshihiigsohhtodgtiedutdegvggt
    fhgvheeivgdtfhguiegsieduieesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilh
    drtghomh
X-ME-Proxy: <xmx:MAjqadqiB_-vg8vBHZheDqWU5YwWwZTqSlBOzmWeW3VtblfHG-3dOg>
    <xmx:MAjqaZ7lR6zwyU8WGPD_Ab8_H68pWVBH8GRc0XzDZWEBrQlekS7hFQ>
    <xmx:MAjqafpTuUGRO3cH149ErcWI1ktH6IdSivFFVLrdeT7nqeMZK1pzpg>
    <xmx:MAjqafJ8cv69BiOcaGherw3aSHrfHYSgdXpdH5ObORuFNqvCqq9FsQ>
    <xmx:MQjqaUavQyk1a90VZKordvDIow1t3pHtRQ4qNDJgmeH8N2_BXVC7gihB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 07:53:19 -0400 (EDT)
Date: Thu, 23 Apr 2026 13:53:18 +0200
From: Greg KH <greg@kroah.com>
To: "1016331059@qq.com" <1016331059@qq.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"mark@fasheh.com" <mark@fasheh.com>,
	"jlbec@evilplan.org" <jlbec@evilplan.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com" <syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
Subject: Re: [PATCH 5.15.y] ocfs2: fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume
Message-ID: <2026042348-activate-registrar-5614@gregkh>
References: <tencent_13981D81EAB7B312D26CA3A023CCF74F6406@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_13981D81EAB7B312D26CA3A023CCF74F6406@qq.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240475-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,c6104ecfe56e0fd6b616];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,kroah.com:dkim]
X-Rspamd-Queue-Id: 41B43451869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 08:51:42AM +0000, 1016331059@qq.com wrote:
> This patch is a backport to stable 5.15.y of upstream commit
> 7f86b2942791012ac7b4c481d1f84a58fd2fbcfc
> ("ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()").

You forgot all the newer kernels as well, we can't take patches for only
older stable branches.  Please provide backports for all of them and
resend this one then.

thanks,

greg k-h

