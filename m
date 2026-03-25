Return-Path: <stable+bounces-230351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOIREs/8w2lwvQQAu9opvQ
	(envelope-from <stable+bounces-230351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 16:18:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E1327BE9
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 16:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A5D9303D539
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB753D348C;
	Wed, 25 Mar 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fC4wFbx9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623E40DFDC
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450842; cv=none; b=HMzyu7Tg9YX9m/vces7wPz09isG4SFv+f2ls9o1RmRZnMzEnmCrIzBe06JJSMhfJ1EVUQK9CGhyCYfx63jPRs4a2EV5eMLxkqmvSbl1ZFI+hYWc8xkrJdvNIRwr8LXO/54j8OTRaWQ2XCPJOZx/dCCOharMH2rZUsCOcZ2uoGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450842; c=relaxed/simple;
	bh=PiccF8KIAiz1/9y5gMKzRlxYq88TiQwROOpY/6mzq+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGWLXsSCEScl6Sua37sOyfBETb5s+PV5vbP3NCcTmKBb4IrqrZ1rK/QHNP6DdkKpx0ZUKiO8I2bryQOOutTyx5PsoOY4F+HO5PVi7wcoUWzB32xJSNv9vUFhP4110suu9nLGYjtUd4DLKk8F8yQqOmO+AhkYm1HbmLeCgc5RxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fC4wFbx9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774450841; x=1805986841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PiccF8KIAiz1/9y5gMKzRlxYq88TiQwROOpY/6mzq+Y=;
  b=fC4wFbx9V08ACYA4cSrzLr5dNtTURjdWD7NgsGfjwakaquUV8QLZ2j2O
   dv9IkwiWFlqsi4pBkK3J+YGQksxby5Hl9QFFECnd2GL2JZzXMult9XLy0
   SZ/5E0nihaJSc1tAmabXM2RUTTm47sZCpljtfa1Iw5fMhIUhjFSfS3rqD
   srMdyyMvNQLYxvizODzyhQrVoXnW+4EaynwolA6BrYm8BZ80+6+t3oij8
   inFw4Dd8/zL7uTnt4Hf+hIuzgYknwGxiFwcPRXtM+LjgsF0WQXPmH2rvP
   3akdtc5miCL3oZogcbWCO9T/B65Dvvdt+/TOse6y1eqtjnC2RNOipnrNV
   g==;
X-CSE-ConnectionGUID: DQoKWCBNRcKX4B1AVfMl5w==
X-CSE-MsgGUID: wi7i2bkFQxiPnnJtDQKI+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74670256"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="74670256"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:00:40 -0700
X-CSE-ConnectionGUID: ddgBB4qCTe+X4lgCNppT8A==
X-CSE-MsgGUID: uxptITx9Rni/S3pZZdLe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229162209"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.56]) ([10.125.110.56])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:00:40 -0700
Message-ID: <2c036114-72c8-4695-8bba-a9c642df5519@intel.com>
Date: Wed, 25 Mar 2026 08:00:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 378/378] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig
 tristate mismatch
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260317163006.959177102@linuxfoundation.org>
 <20260317163020.886316423@linuxfoundation.org> <acK_mxmLlvD5vQog@kbusch-mbp>
 <551037c4-665e-4701-9689-a75bdabe4211@intel.com>
 <2026032511-construct-blurt-07cf@gregkh>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2026032511-construct-blurt-07cf@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230351-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 054E1327BE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/26 1:56 AM, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2026 at 09:49:43AM -0700, Dave Jiang wrote:
>>
>>
>> On 3/24/26 9:45 AM, Keith Busch wrote:
>>> On Tue, Mar 17, 2026 at 05:35:35PM +0100, Greg Kroah-Hartman wrote:
>>>> 6.19-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> No objection, but a little confused how this got to stable before
>>> landing in Linus' tree. Does stable pull directly from downstream
>>> subsystems now?
>>>
>>> Speaking of upstream, will the CXL maintainers be submitting a pull
>>> request for the staged fixes soon? I'm just getting new bug reports from
>>> people testing 7.0-rc, so wanted to check in on that.
>>
>> I can send it today. Looks like I got enough days in linux-next soaking for the PR.
>>
> 
> I took it as it was "obviously" correct, fixed reported regressions, and
> it was in linux-next and going to Linus "soon".

It's now in Linus's tree as of yesterday. We are all good.

> 
> thanks,
> 
> greg k-h


