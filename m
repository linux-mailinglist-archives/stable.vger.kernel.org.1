Return-Path: <stable+bounces-217833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLq1Jo3VnGkJLAQAu9opvQ
	(envelope-from <stable+bounces-217833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 23:32:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C617E64A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 23:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6DDC3016C97
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D837B3EC;
	Mon, 23 Feb 2026 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek0utXGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58F334C35
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885882; cv=none; b=S/qlcPuWye+LMFj7s2mwVs5TmmLjwXW2ilZfk566CPvoPZHTKiRAm7q6aI9ksClUWYvz6T7xBHGmWaAlIMEpfvlma87xT3zQ628Tjn1MzOjZisH5Cn1JHA8e7+cBqRz0xOMhH22k6yRxGiJLz1KjgyIYyTstQEZggUXbdfUu3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885882; c=relaxed/simple;
	bh=1WD9xeosHoEBtsVYyWwa4VxQ1sSPNWP0Pr+iMgVpsKM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=td+w7/oKXKIaa6JHsLSpt26DmRNuKg2Wgn4vsCx0ThGPs1rFxZCCpTcRIxRU/rhq/Ox/b1bFPJY4jdVCJkvoujX6rekK2CtL0l5rpBphZUQc2BIIpTPiMFHLAdUZFG3DDuCGl0zUImOu0EicHNs5Cfen2LJEFhR3kvpVjVtHjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek0utXGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537CAC116C6;
	Mon, 23 Feb 2026 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885882;
	bh=1WD9xeosHoEBtsVYyWwa4VxQ1sSPNWP0Pr+iMgVpsKM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ek0utXGynzy0ukSzdHJQxPwcBlfPugCsSAsIUF3l69ub5/30nsDItHtx90euy63Q5
	 59M1RX81HxhoFZrTPwcSLbEJVcgcjmm0THAZlML6bBqOhV/Q/HlmkNKcQV2GPLxMpy
	 JxZUZlXfWG/v70VadAMk4uhcomGX3m4RbOQQr3Pl+gEQk35FFucakxNCxKs6fSUrBq
	 6ps6K7xcFdLtJfMO4+MjaYmlWlq3jHCMlOflmnNxhubz5YoQtcsyCS0oVsoKENcg6Q
	 K+qBq4vd4UGHTgwL92asu8VFl/m7UB1njptxAN112amazRJdnwIyrkrOL9E+9Julrp
	 jM7SWwqERWLJg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 23:31:18 +0100
Message-Id: <DGMP4FBY8958.1KNWJH7IW7M3I@kernel.org>
Subject: Re: [PATCH v3 1/3] gpu/buddy: fix module_init() usage
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Greg KH"
 <gregkh@linuxfoundation.org>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, "Matthew Auld" <matthew.auld@intel.com>,
 "Dave Airlie" <airlied@redhat.com>, "Peter Senna Tschudin"
 <peter.senna@linux.intel.com>, <stable@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>, "Arun Pravin"
 <arunpravin.paneerselvam@amd.com>
To: "Koen Koning" <koen.koning@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <DGJPMOESHINC.1NGNT8LLY8DKW@kernel.org>
 <1771594440.99434@nvidia.com> <2026022156-citizen-shredding-5d6d@gregkh>
 <cdc31857-c9a0-4d05-a243-780dc9819cb7@nvidia.com>
 <b45a50ce-de96-42ee-90c1-0a6cd7a78cc0@linux.intel.com>
 <DGMAUQLZGPZB.FWELZM9GYP0Z@kernel.org>
In-Reply-To: <DGMAUQLZGPZB.FWELZM9GYP0Z@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217833-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 013C617E64A
X-Rspamd-Action: no action

(Cc: Arun)

On Mon Feb 23, 2026 at 12:20 PM CET, Danilo Krummrich wrote:
> On Mon Feb 23, 2026 at 12:17 PM CET, Koen Koning wrote:
>> Thanks that makes sense, then let's just stick to addressing the current=
=20
>> regression with gpu/buddy in the drm-tip tree.
>
> The patch should go into drm-misc-next.
>
>> Joel, could you grab the v1 of this patchset (or the v2 with with=20
>> subsys_initcall, either works) and try to get it applied to drm-tip?=20
>> Since this is my first time submitting patches, I'm not really sure how=
=20
>> to proceed from here, and it will probably be faster if you have a look.
>
> I think we should land your original v1; I don't know if Joel can push to
> drm-misc-next, if not please let me know, I can pick it up then.

Actually, since GPU buddy has a separate maintainers entry, I will leave it=
 to
Matthew and Arun.

(Cc'd you both on v1.)

Thanks,
Danilo

