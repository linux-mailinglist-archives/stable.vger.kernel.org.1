Return-Path: <stable+bounces-45244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AD8C7167
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 07:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E411F2257B
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492119BA6;
	Thu, 16 May 2024 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgF1RfJv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0A11CA0
	for <stable@vger.kernel.org>; Thu, 16 May 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715838424; cv=none; b=srsZ2kkeruOHk8f/wP6qPirGHNatuq4amSeWAaGWu26h21ANmCM/+rziCTgEfaz6COG1sCv4p73+VSG0QxhnLRoAIctXkUyLKs+Wii15IuEP8QzLMoI4hkZQY6NMPoOzSBVULnjJC2PAZLZqADF3xNTLKqc6M235EDxEy1CI9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715838424; c=relaxed/simple;
	bh=8hSmjzd1gV+QWKxKx2j1i1jfiYLlJx5ie51nM1nQ7nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WayYfBdRhCOuVW/Hc/q4DL4ysrSF5UOBEA1dP3QtCmrDUO2teUtcKmJmp7ayY2E9ZQmrERbuKb6GmxJ3Ti1oLQlnZ7lP6isuJ6RyACCSsWDxhCIi3wRWpIQnh0GQ8Thlmz18EyKxo3/ZqC+cyrAlLTtBnWR5u3UBTOOQZc+NYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgF1RfJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C14C113CC;
	Thu, 16 May 2024 05:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715838423;
	bh=8hSmjzd1gV+QWKxKx2j1i1jfiYLlJx5ie51nM1nQ7nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgF1RfJvmhT6WGULDoUWkopguFamzrmDeFsd/yOyy/3eNeFwEkXmwj3RwPHoweMo2
	 SnBCUDNWG2nS4a8AZThL/7OiRa2CwNTrH0wPuyd1v0Do90FSMp5pHavyjlAsOoIhXi
	 09QPbfb25lWLPnAVfXiobc8deoR6rE/VhydSgogM=
Date: Thu, 16 May 2024 07:46:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: "Zaki, Ahmed" <ahmed.zaki@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>
Subject: Re: Fix Intel's ice driver in stable
Message-ID: <2024051655-manned-aviation-fa48@gregkh>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
 <PH0PR11MB4886A5132BDFF44F0BB12577E6ED2@PH0PR11MB4886.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB4886A5132BDFF44F0BB12577E6ED2@PH0PR11MB4886.namprd11.prod.outlook.com>

On Thu, May 16, 2024 at 05:12:40AM +0000, Samudrala, Sridhar wrote:
> We need to fix this ASAP. Flipkart reported this issue with 6.1.x stable kernel.
> Not sure why this commit was backported to LTS kernel as it is not a bug fix, but introduced as part of enabling live migration.

Back in March you were notified this was going to be picked up for the
stable tree as part of the AUTOSEL work:
	https://lore.kernel.org/r/20240329122652.3082296-63-sashal@kernel.org

Any reason this wasn't noticed then?

thanks,

greg k-h

