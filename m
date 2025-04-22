Return-Path: <stable+bounces-135049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B0A95FA8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3A83A6F99
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E11EA7CE;
	Tue, 22 Apr 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u1iL7KWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADE524C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307625; cv=none; b=IgXHlZKuNOVMRNreyHvrt5EVnH7rqlUr9YLuEPYjP5bAz4OuWN6Kvq4/l+BJfy8EL6454Y0revedWCZXujPC8iqBuSYZX0G3KfLTz9016wsmfoekO/eAIIDNDoMa42PasUBgzOttTDHZX+SHdAgWxiALq1a1XlxVvsM8h7+HGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307625; c=relaxed/simple;
	bh=d8zJCp74lA9uP8AXIaSlEWut+LN6uXIJ55QqHCxLVbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRB4/0plJ16A+SgTW/XhEQjHGBloEF/Ok/nrrI3Hkxm+sDvOAukxDgh4jA1HPWl7X1LIGwhn13PqLPovtQUHS14Dl9+fvEgkj7cZGTC4j0x9B3T8vXqtiqXeS3JfBIFrzLuTrv0scpZz3GszN0Q7TbYSlKVQ6Ji1NXYu5W2i0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u1iL7KWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45290C4CEEC;
	Tue, 22 Apr 2025 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745307624;
	bh=d8zJCp74lA9uP8AXIaSlEWut+LN6uXIJ55QqHCxLVbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1iL7KWZj8xXSHit+OTm5H1yNa/OWm6pryuum0XrZ+4GmLKGcOb68XT+tK75zIOFW
	 07+TFWCOMBdUI7CcfUI8uA0LupUVRKk2PsPOktTV40Srjo8Ut6VSQdUTqZ/SENxwiT
	 MwiUpTTSMIAlwj6gwwo78BBfP3wxrrsmQDHObNb8=
Date: Tue, 22 Apr 2025 09:40:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: stable@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: Please apply commit d81cadbe1642 to 6.12 stable tree
Message-ID: <2025042207-bladder-preset-f0e8@gregkh>
References: <j7wxayzatx6fwwavjhhvymg3wj5xpfy7xe7ewz3c2ij664w475@53i6qdqqgypy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j7wxayzatx6fwwavjhhvymg3wj5xpfy7xe7ewz3c2ij664w475@53i6qdqqgypy>

On Mon, Apr 21, 2025 at 11:00:39PM +0530, Naveen N Rao wrote:
> Please apply commit d81cadbe1642 ("KVM: SVM: Disable AVIC on SNP-enabled 
> system without HvInUseWrAllowed feature") to the stable v6.12 tree. This 
> patch prevents a kernel BUG by disabling AVIC on systems without 
> suitable support for AVIC to work when SEV-SNP support is enabled in the 
> host.

We need an ack from the KVM maintainers before we can take this.

thanks,

greg k-h

