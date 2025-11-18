Return-Path: <stable+bounces-195079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DFBC686A3
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12A5E380A5C
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD993254AB;
	Tue, 18 Nov 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtYsAHwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43D32142A;
	Tue, 18 Nov 2025 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456356; cv=none; b=HKxF9/ztE14Q+qpmJqT3tvQfGoTND4rBl6puAjQSFed53SZve+dexHbd2+Rw5XXsqjkuHTJrWZBBqS2sxIHDBFRYyT9Ck1GJgnvlc49BKXHYN3aQF/Aoe3enPHPQMwe10jjdUh6NOQI/aDx2iHzo3XQhsFL+PQf1UqyhLli4acQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456356; c=relaxed/simple;
	bh=0zNt1gyxLzLETaCJFmjggT3wS7/Jm82U80jg5Q40JqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laaG36yz6RoyCJUKqUgREZtHq7uNz4UIGnzY582kbgzVWaGpb+e9WB10MH/ArWcynnDHy4mfZZTCIv7yrh1c2nDzUUlxJpa8Ur91mAwqkTidB75oALaM7ybzIYnpDFlMN0TrUlnMMPAqG4QfuQhtQGiK/4riXzAfsKUGNkH6lFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtYsAHwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D14BC4AF66;
	Tue, 18 Nov 2025 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763456354;
	bh=0zNt1gyxLzLETaCJFmjggT3wS7/Jm82U80jg5Q40JqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtYsAHwpdZ/qINUxLi6zXliyxSL5hkKsZXECw9guNVPEQrXr+7S/KmYFUOC7HGBPu
	 w5192nOA6UVVHlvQDT/0WYP9cmIc8qSS7lXkDAPjANpsPPp3lKFCIecHJvJj/zzroW
	 I4JWiaJ8xB5v2xw3pRGj9ZBIxvfdTjIA7gCf9+G4=
Date: Tue, 18 Nov 2025 03:58:58 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Message-ID: <2025111848-gusty-unclothed-9cc5@gregkh>
References: <20251117174315.367072-1-gulam.mohamed@oracle.com>
 <20251117174315.367072-2-gulam.mohamed@oracle.com>
 <2025111708-deplored-mousy-1b27@gregkh>
 <IA1PR10MB724026C01ABF778B9E9EA10698D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR10MB724026C01ABF778B9E9EA10698D6A@IA1PR10MB7240.namprd10.prod.outlook.com>

On Tue, Nov 18, 2025 at 04:58:24AM +0000, Gulam Mohamed wrote:
> Hi Greg,

Please do not top-post.

> Thanks for looking into this. This is the 2nd of the two patches I have sent. The first one is "[PATCH 1/2] Revert "block: Move checking GENHD_FL_NO_PART to bdev_add_partition()"". I have mentioned the reason for reverting both these patches in the first patch.

That does not mean anything for this patch, you can not have no
changelog text for it.

> Also, this is for "5.15.y" kernel.

Really?  Why?  Where did it say that?  Please be explicit and say that
somewhere obvious so that we know this.

confused,

greg k-h

