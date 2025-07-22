Return-Path: <stable+bounces-163697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E2EB0D925
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2354562379
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B702E8E16;
	Tue, 22 Jul 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yhBb761t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572542E92A5
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186511; cv=none; b=ZOhfXladYbr66oK/A/HxuIExQjqnIbBTLLgkchv9JMAmorbuUrMwYiHucQ7aNtDSi/Znyl09aDOTXR/d760YMRuopGYUZRagYZuIN5smy5bnCekF0b5uLeCLdDOBMBziUr0O5PneDZhQ3q8BMN7ybqy2vwdn79sQEhb9QdaKT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186511; c=relaxed/simple;
	bh=rMN80HF4py2Yv2Mi8Yx91mg8Jubafoat69sWoDW3uPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLQbqpHg3KNp317ItQZC1E6pSpo3j8YFnEXuwr5Dt8fQDlaqnu1ounKWUftzoAOCJ4yUsSTwzTKSbwXu6h5UyeXltSBVWF4Bf4oJxl1ai+vZz2c4nU4l3pRzWSq2fTVmtUlnmEmH2gjt4bDzzPQvtouEpqy6sgKKHiZMhJRl6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yhBb761t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D6C4CEEB;
	Tue, 22 Jul 2025 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753186509;
	bh=rMN80HF4py2Yv2Mi8Yx91mg8Jubafoat69sWoDW3uPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yhBb761tfHH8gCO6Ec9oct18hjkCg2KOtaR/+JEaFjIXPBi5lhCNCjeziUcL9YKQY
	 UIHisejAiWJxyDA0p5/CDKV/6dalMN4L1KO469wJ7zOKXWgA2CevBvyTACk4O3fvAY
	 ruf5q1c3tOrRca3YUA6z69+fHZ8LmWqL37Nm/Oeo=
Date: Tue, 22 Jul 2025 14:15:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddhi Katage <siddhi.katage@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH 5.15.y 0/4] Fix blank WHCAN value in
 'ps' output
Message-ID: <2025072254-numerate-uprising-72d3@gregkh>
References: <20250722062642.309842-1-siddhi.katage@oracle.com>
 <2025072252-urban-triage-41c9@gregkh>
 <CY5PR10MB601266A9818ADA77134550EB8B5CA@CY5PR10MB6012.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR10MB601266A9818ADA77134550EB8B5CA@CY5PR10MB6012.namprd10.prod.outlook.com>

On Tue, Jul 22, 2025 at 11:13:08AM +0000, Siddhi Katage wrote:
> Hi Greg,
> 
> This patch is already present in stable-5.15.y.

Ah, missed that, thanks!

greg k-h

