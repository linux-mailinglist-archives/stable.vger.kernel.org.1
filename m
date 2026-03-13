Return-Path: <stable+bounces-225226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBmHNNNds2k3VgAAu9opvQ
	(envelope-from <stable+bounces-225226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 01:44:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3D27BB66
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 01:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E5483035ABE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ECF30DEBA;
	Fri, 13 Mar 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/zIAQn6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC473033EA;
	Fri, 13 Mar 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362633; cv=none; b=BmyzGlRVCCOntVqR0dEPEHaLQvEeIrROkwViOV/3xLkj7rbpHVEMpIHOPraW41KEs6QCSs6DINmdufO6CkCtiU+FijMy2ctPK7IDWWEmULzbOOm+hU4lPqcVNA82zzFmT0UK7s5p23I+hVm1nPRa3GhL/91GJh2j1fy7MTc1GYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362633; c=relaxed/simple;
	bh=LTD2lbQAO+tJ271s0nzasUduJV8H/UtDSQ4IGnu+i7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqYKauMqjvpp9VkAHOtmQ/UtIcC+OlfiZ/XbktmF3Js8ifBGZKu18RkddxgDY5oczw0FsbOEk1GJcQTd1p9UKk7f/FT5BMXGy8nLf+NlUpXx6aU1Wi7xH6ACk1Pe9Lcg0g9Y6zc9KPPQZ0ibRGeck0hNcojNg+j/8qweTytJwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/zIAQn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97348C4CEF7;
	Fri, 13 Mar 2026 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773362632;
	bh=LTD2lbQAO+tJ271s0nzasUduJV8H/UtDSQ4IGnu+i7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/zIAQn66l1wIovKBLqDsTEs1t3BMEonh3pf+ZxkTPggb6rn9CG4GCL2/wBtWZPxG
	 /bYDeV1xFAgey4IYWiafaPsQ132sjPdfg8nyiCwdedE2EBjWC2uH97/eq/lrlm2PLy
	 TNoGPxqDpaMgF5VVefI4q33ow/JTGYWfK4nDDdaaDPTNluZJZZc2xkOTXbKPVomavg
	 13c6p3RwjNgI7maf0GOWPPkG/k5ikTbeT6MFDFlTP99cjfrARUVLTndPl5QbrMKnHW
	 qza/GLaTKdFRhblZHKhHXStKapuEE+5pCzVM8jmP+F+uwBWDbg+Q8nXOTUBJU96Cdw
	 mfj9YSu46C1/A==
Date: Thu, 12 Mar 2026 20:43:51 -0400
From: Sasha Levin <sashal@kernel.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 6.18.17 -- build regression
Message-ID: <abNdx_cQR_BqMm3z@laps>
References: <20260312112454.940017-1-sashal@kernel.org>
 <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225226-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AA3D27BB66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 06:24:19PM -0400, Cal Peake wrote:
>On Thu, 12 Mar 2026, Sasha Levin wrote:
>
>> I'm announcing the release of the 6.18.17 kernel.
>>
>> All users of the 6.18 kernel series must upgrade.
>>
>
>Hi,
>
>This release breaks my build with the following output:
>
>  LD      .tmp_vmlinux1
>ld: drivers/cxl/acpi.o: in function `add_root_nvdimm_bridge':
>acpi.c:(.text+0x16f): undefined reference to `devm_cxl_add_nvdimm_bridge'
>make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>make[1]: *** [/home/cal/linux/kernel/build/linux-6.18.17/Makefile:1242: vmlinux] Error 2
>make: *** [Makefile:248: __sub-make] Error 2
>
>I've attached my gzipped config. Commit af9bf9889663 looks possibly
>guilty, but I don't have time at the moment to fully verify.
>
>Please let me know if I can provide anything else.

Hey,

Thanks for the report!

Could you please confirm that cherry-picking 93d0fcdddc9e ("cxl/acpi: Fix
CXL_ACPI and CXL_PMEM Kconfig tristate mismatch") fixes the issue you're
seeing?

-- 
Thanks,
Sasha

