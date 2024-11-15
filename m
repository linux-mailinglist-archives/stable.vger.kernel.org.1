Return-Path: <stable+bounces-93084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940509CD693
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E89B238EF
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7604A17CA1B;
	Fri, 15 Nov 2024 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qoPCwyDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA017C7CA
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648451; cv=none; b=ExRl1CjaiTqatLauptdf/a7lcVOxEqAOexewqpDjvpiRAi7aG7XFpBCctHbQJJOGVriBdJbTehXZ4NPUeeGRWZltPagQTFAGM/H6lSKB1Z0u/K23MmJ2/nKXMcjvczyJcLoWydPvmCWa57hVnf6mUAD+913B41n+LjQcFGQZ8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648451; c=relaxed/simple;
	bh=wiV5GiCZpCIgtVvGoa89k+Nk5V9CwANIeM0ilQDORqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWAPkX0SIU4pfs4WED5W5OfQhnE9CA7xKcEFvaRlLhUAzLzpM5G2vjJZI8zvk1H9VSbnMmQu10VWNYTvvka8wuoF2Gs3cq6bE+hXNc/TyznIfTjesHgNpESX+W7LseNRRbsmDtzMEqZ/5+kRwgZceuiYhfEeFrZXmuDkYLEbqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qoPCwyDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92268C4CED0;
	Fri, 15 Nov 2024 05:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731648451;
	bh=wiV5GiCZpCIgtVvGoa89k+Nk5V9CwANIeM0ilQDORqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoPCwyDql9aHhVDGtaI/AirmJs6tEe0qLGa3rdw8VIvrGQ585PsHBLdnhcNVuDBRj
	 q4LcqLClpWbvqEzgRRHeIBW0jYGTdR1fWPPhbAHBN+K3Y61aY8dHxGXrbs4kmzIbiy
	 3q8PIACAQoZg5V9ncXTAtcvw0CMLYJU10IWjYU10=
Date: Fri, 15 Nov 2024 06:27:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y 0/4] Backport fix of CVE-2024-47674 to 5.10
Message-ID: <2024111517-chooser-could-1159@gregkh>
References: <20241114153443.505015-1-harshvardhan.j.jha@oracle.com>
 <de4226be-1b8f-4fdb-86ed-b9b077b839b1@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4226be-1b8f-4fdb-86ed-b9b077b839b1@oracle.com>

On Thu, Nov 14, 2024 at 09:21:16PM +0530, Harshvardhan Jha wrote:
> Hi there,
> 
> On 14/11/24 9:04 PM, Harshvardhan Jha wrote:
> > Following series is a backport of CVE-2024-47674 fix "mm: avoid leaving
> > partial pfn mappings around in error case" to 5.10.
> A small correction, the 5.10 here should be 5.4 and similarly on the
> subject line also.
> If you want I can send a v2 but I hope that's not necessary.

No need, all now queued up, thanks!

greg k-h

