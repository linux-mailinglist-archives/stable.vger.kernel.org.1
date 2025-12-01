Return-Path: <stable+bounces-197711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A729C96D96
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6608B4E1635
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DBE306B24;
	Mon,  1 Dec 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="IV9Up3JV"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96999303A2C;
	Mon,  1 Dec 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587676; cv=none; b=S8BubU5HCkv1tB6VXUFTRy7REuqXgnt4y53uw3bkgcdrx2M/jpNIRyyjQEyvv9SgPXdUSEpZzXn7pVXEEmUsRwG7M+Yzrx7n8n6/G7PfMCjOTOpvSgIhStklAhsZxpVX8iifUkVHHBSbsWgE4ebTIYAGOl6yn8kf4sjVggKEX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587676; c=relaxed/simple;
	bh=4MwKTvfcfQq6mKKQ5gQeVPqPnTc4ySxA8QCIRnZK0j0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFxUJ0PpBrHsgkLB+v50rvG/5jE1NEnKryAXdyU8H0YSmgz5nkM0xH+Ot6S0WCYRS/tD2GTsymvmwY1JEvbM7nU+wIiqxhEBh26DozmONlurViKmXNLh/48+AAOynb3Ty78rXHkGX36r2oDZ7abZ6elgRQIrXCutSbgE1P3e8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=IV9Up3JV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7C06D207B0;
	Mon,  1 Dec 2025 12:14:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cdwlBYeyqKvy; Mon,  1 Dec 2025 12:14:30 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E609F201A7;
	Mon,  1 Dec 2025 12:14:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E609F201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764587669;
	bh=1PUjlLo05W8BNxSk+z6UsGqcpcTN8fJ3CfH/pVpaSz4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=IV9Up3JV8Xfc/+Y8Jw4n5HD3mB1bm2STnAOPg3HIFiPELAMM0Pwl3cDK38e5LCPXW
	 K7yCOJmjocVXe/oqb0ctPN6DQ6ZdWyfARNS/gOGxKMWiVFMcX3z47uUpepPLx7CjjG
	 8EV1TRrv2qleVLeiBukZbWGXRJwE8mHTEXLXMwHfClmsAgZyGNRb0DU3PylHAC5vyv
	 cmoZrkybCKDmWj2azqjQGa5dEIvxtBHSgTFkUkneDeHYgZXOz0h6MfI7l3meJ8hvC0
	 fnslNr8UeKO95CyAQXKILE3KAq17njImrTI+gNxBP8U/Q2wlI7xOyV+EBMn2TKcoB8
	 ZVKQ5bT2MfvsQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 1 Dec
 2025 12:14:29 +0100
Received: (nullmailer pid 1220425 invoked by uid 1000);
	Mon, 01 Dec 2025 11:14:29 -0000
Date: Mon, 1 Dec 2025 12:14:29 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Slavin Liu <slavin452@gmail.com>
CC: <stable@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete
 x->tunnel as we delete x")
Message-ID: <aS14lT5jZKpwAg4N@secunet.com>
References: <20251118151140.89427-1-slavin452@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251118151140.89427-1-slavin452@gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Nov 18, 2025 at 11:11:40PM +0800, Slavin Liu wrote:
> Hi,
> 
> I would like to request backporting commit b441cf3f8c4b ("xfrm: delete 
> x->tunnel as we delete x") to all LTS kernels.
> This patch actually fixes a use-after-free issue, but it hasn't been 
> backported to any of the LTS versions, which are still being affected. 

This was explicitely held of from backporting due to problems.
It should not be backported without:

10deb6986484 ("xfrm: also call xfrm_state_delete_tunnel at...")


