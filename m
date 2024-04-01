Return-Path: <stable+bounces-33946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E84A893C30
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F271B20E89
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2B4087A;
	Mon,  1 Apr 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="k+UWcuZz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/9QQkCP"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BE621
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981391; cv=none; b=r46tGGh5rwYf4TmpTMQjtLBdcT6XHRFXw0NODlLWnkwWQkNLWKhydsA5eX3F3KPdOPdWIUrv2/XZChslpdej9hw2o2rOwQHHWd2c4EA/R0pYEcfzBIh39XVj88GdLlVIO/m45VxF/aJGMZQj/jaw8iCvtHvSwgHL90lOvDEck+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981391; c=relaxed/simple;
	bh=i6k2FVTbbVei4IWSPze8PvcNKLnw/SZ61KgCMvVF8OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=carGOZ+zbfihcLFXcyL4qXGv282EeIYsyztYG77q0MvbCDZDA1bRYQEVyURP//vdJ7mYW3fEIDCKC7FamjiCcUIR/fBJXCRRO7YCExwmeFFvEfa1KU+bUavdnvdTVR//5AdcR5UMCUptIvMTf7IOO/cGbqP9Ddm+Ok6HNiDlDY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=k+UWcuZz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/9QQkCP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 546F113800AA;
	Mon,  1 Apr 2024 10:23:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 10:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711981388; x=1712067788; bh=sv01l52tnC
	51mlCwMqYtGv4G45zG0vhaaPUoA/pKoXc=; b=k+UWcuZz/zQTgZWBV0z+tBhVNm
	P18DZ1dcWc8fplDW+pb+E+LWrXwQe706hbQo0a3PBXpmPiHzmhRHBLjZ3IBx9WL+
	1261Jcg63fmdLDyBmrKYuQPWoTN7NmAOFvcX/wcWpRKuJ9Y3HFhOkJg2ho44MtB2
	eDM0/yFqEtFIb2bqoXrjsuB+5a+3GABeeek/yqSPRvLR9SpGYTGvEc1mT/NjBVIk
	jdzndSlreMLa6+I2ruMOPuFMyApGOdVly8dcNsvsGCp+EqGw2Cs4Y1sZnw/FvHga
	8DpJSbceys93/g/iF6EjE/UWMa9fBSHQ5AQos3J3PLeR2roVwp79OEltLYrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711981388; x=1712067788; bh=sv01l52tnC51mlCwMqYtGv4G45zG
	0vhaaPUoA/pKoXc=; b=o/9QQkCPelBKLoEU1UrgSJZ2jTAwbAcv5q2gegdFfrMz
	1lc6ep6VYuYicO4HA4uBeKQ/a25xqqk7pPhIWB0V59YiKa2c/4x6N3Cc8jpAG3mP
	ogVJ1ESn4UTlhWHvktBRP7WdnxMsjymaFnqX5C0P7/ThIQsixsdn76FjOnWGc8Aj
	0zOIgiz9Q13vsvl6MXsCP19AL5qR1Zqu40+RApSs3BjhhJIOq/IwyeJMg/0QBYlf
	6pS98EqEtzV9crHZtVbKzR3yS1Amx1AqSyd5/08aYYxRmSugRnL54wb6jOus0752
	lz8MJVhEacnokjjEXRMl/1pWVJatw2xdmfgw1QF8dw==
X-ME-Sender: <xms:TMMKZszBiuFhTTAC5Q8VeF6L5m0hgM9u8-w0sCdxUButcSgxdIlqRA>
    <xme:TMMKZgToN4rKNScZGtoqTa5lKj42qh9LcXVUltmLPn9SbFVPEurF2WWsXvxRVh3c_
    M-ia7HuAp7htg>
X-ME-Received: <xmr:TMMKZuW5UWcJg1f54fGKgf3KuBagbR7C1OZG0m7z2SnPkygQmyX0UDsNkHizqRiM5rdEDEVHBu29r1ave5kGGJPms1Y_1hMd9nXxVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:TMMKZqhQz6TnsYxrnEhEwG9Aa7Y6qCk0jj2gE1advKvETBi-XDbmPg>
    <xmx:TMMKZuAL4LUI7fhnLBtNNsZ0xwCYfqHG5dLu37jCmX0XcmKly3qNqA>
    <xmx:TMMKZrLqdm6eD2T41VYZH_NXvajZMu87_OASPL4N9HTjrXt2S_Uusg>
    <xmx:TMMKZlBrMwrKJGC1sDMDjXrfm1SVtwmVmahrYtcNfgZAQvLrJjVkmg>
    <xmx:TMMKZmvreSAMqnHkhELL4i9gNMe9f08j_hJm6mzjA_33ALI9aezezg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 10:23:07 -0400 (EDT)
Date: Mon, 1 Apr 2024 16:22:57 +0200
From: Greg KH <greg@kroah.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	stable@kernel.org
Subject: Re: [PATCH 6.8.y] x86/sev: Skip ROM range scans and validation for
 SEV-SNP guests
Message-ID: <2024040145-fleshy-shakiness-2d6f@gregkh>
References: <2024040102-umbrella-nag-c677@gregkh>
 <20240401141202.1704141-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401141202.1704141-1-kevinloughlin@google.com>

On Mon, Apr 01, 2024 at 02:12:02PM +0000, Kevin Loughlin wrote:
> SEV-SNP requires encrypted memory to be validated before access.
> Because the ROM memory range is not part of the e820 table, it is not
> pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> to access this range, the guest must first validate the range.
> 
> The current SEV-SNP code does indeed scan the ROM range during early
> boot and thus attempts to validate the ROM range in probe_roms().
> However, this behavior is neither sufficient nor necessary for the
> following reasons:
> 
> * With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
>   CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
>   attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
>   falls in the ROM range) prior to validation.
> 
>   For example, Project Oak Stage 0 provides a minimal guest firmware
>   that currently meets these configuration conditions, meaning guests
>   booting atop Oak Stage 0 firmware encounter a problematic call chain
>   during dmi_setup() -> dmi_scan_machine() that results in a crash
>   during boot if SEV-SNP is enabled.
> 
> * With regards to necessity, SEV-SNP guests generally read garbage
>   (which changes across boots) from the ROM range, meaning these scans
>   are unnecessary. The guest reads garbage because the legacy ROM range
>   is unencrypted data but is accessed via an encrypted PMD during early
>   boot (where the PMD is marked as encrypted due to potentially mapping
>   actually-encrypted data in other PMD-contained ranges).
> 
> In one exceptional case, EISA probing treats the ROM range as
> unencrypted data, which is inconsistent with other probing.
> 
> Continuing to allow SEV-SNP guests to use garbage and to inconsistently
> classify ROM range encryption status can trigger undesirable behavior.
> For instance, if garbage bytes appear to be a valid signature, memory
> may be unnecessarily reserved for the ROM range. Future code or other
> use cases may result in more problematic (arbitrary) behavior that
> should be avoided.
> 
> While one solution would be to overhaul the early PMD mapping to always
> treat the ROM region of the PMD as unencrypted, SEV-SNP guests do not
> currently rely on data from the ROM region during early boot (and even
> if they did, they would be mostly relying on garbage data anyways).
> 
> As a simpler solution, skip the ROM range scans (and the otherwise-
> necessary range validation) during SEV-SNP guest early boot. The
> potential SEV-SNP guest crash due to lack of ROM range validation is
> thus avoided by simply not accessing the ROM range.
> 
> In most cases, skip the scans by overriding problematic x86_init
> functions during sme_early_init() to SNP-safe variants, which can be
> likened to x86_init overrides done for other platforms (ex: Xen); such
> overrides also avoid the spread of cc_platform_has() checks throughout
> the tree.
> 
> In the exceptional EISA case, still use cc_platform_has() for the
> simplest change, given (1) checks for guest type (ex: Xen domain status)
> are already performed here, and (2) these checks occur in a subsys
> initcall instead of an x86_init function.
> 
>   [ bp: Massage commit message, remove "we"s. ]
> 
> Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/20240313121546.2964854-1-kevinloughlin@google.com
> (cherry picked from commit 0f4a1e80989aca185d955fcd791d7750082044a2)
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>

Now queued up, thanks for the backport!

greg k-h

