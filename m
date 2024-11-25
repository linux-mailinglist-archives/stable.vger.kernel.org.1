Return-Path: <stable+bounces-95357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CBF9D7E2C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233EFB239C0
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03729CF0;
	Mon, 25 Nov 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OuAIgJUe"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A838218D64B
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524941; cv=none; b=npIsCFqm3GkMsHxkHAOxEHO6jLLx8mogpxLcXyCye4/qCGDir6imc/AWEOedBCjb/7rMYPqzb9sEVrODcJhe4AaMva+HOONbqk1wJQmiWZ/NT0cSmiR9oi7zPsVjrrfimkmpO3jbb2K90p6oRJAtE96s36nXn9qNVogO6cYCADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524941; c=relaxed/simple;
	bh=HDfW3jVxCWdYw7T6W6STfvhIsTfJuxTDMyWxf/iJsfw=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvJv//zsPwbmOidHQm0bt1zOtaZn3oCBK5KkZ+KeftPNO9hf43vFXjpFgIcjvT59M81s2Pcri8xr+x4db2fx5vOXplSesewTaVTdWV6gxKs3b7dCbgZVDrL0Jw63m/u4dh4k9+lF3hsSakQKeCQzP0S/t+mXBIZYONXGeqyjNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OuAIgJUe; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732524939; x=1764060939;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HDfW3jVxCWdYw7T6W6STfvhIsTfJuxTDMyWxf/iJsfw=;
  b=OuAIgJUekXBXt3mz1WJAgVDXqJM9AT4aCWmmdytyv17vxXM5xsh5q8qv
   9/hzbpGb4hf0F3n71Yw150TiXBygzMo8JCrkz99sAt3PiBKqgDqFTz0Q8
   HFU3kZWeN0fDfnLx/22xZ90mDead63RimwnmiBdmpPSjMFklETVHjyLFU
   w=;
X-IronPort-AV: E=Sophos;i="6.12,182,1728950400"; 
   d="scan'208";a="44171384"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 08:55:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:57842]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.54:2525] with esmtp (Farcaster)
 id f21d2487-34d7-4818-b323-09540143d2c2; Mon, 25 Nov 2024 08:55:36 +0000 (UTC)
X-Farcaster-Flow-ID: f21d2487-34d7-4818-b323-09540143d2c2
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 08:55:36 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 25 Nov 2024 08:55:36 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com [10.15.1.225])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTP id 11A40A047E;
	Mon, 25 Nov 2024 08:55:36 +0000 (UTC)
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 9DF3223E2; Mon, 25 Nov 2024 09:55:35 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: kernel test robot <lkp@intel.com>
CC: <stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 5.4/5.10/5.15] cifs: Fix buffer overflow when parsing
 NFS reparse points
In-Reply-To: <Z0PftUzqwoftS1ri@ca93ea81d97d> (kernel test robot's message of
	"Mon, 25 Nov 2024 10:23:49 +0800")
References: <Z0PftUzqwoftS1ri@ca93ea81d97d>
Date: Mon, 25 Nov 2024 09:55:35 +0100
Message-ID: <lrkyqiksby9o8.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> Hi,
>
> Thanks for your patch.
>
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
>
> Rule: The upstream commit ID must be specified with a separate line above the commit text.
> Subject: [PATCH 5.4/5.10/5.15] cifs: Fix buffer overflow when parsing NFS reparse points
> Link: https://lore.kernel.org/stable/20241122152943.76044-1-mngyadam%40amazon.com
>
> Please ignore this mail if the patch is not relevant for upstream.

The commit id is there but in upstream <sha> commit, wrong format.
I've sent a v2.

-MNAdam

