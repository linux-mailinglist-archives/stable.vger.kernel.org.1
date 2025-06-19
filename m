Return-Path: <stable+bounces-154803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3740CAE0625
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1FC3A6A21
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFB23E347;
	Thu, 19 Jun 2025 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBNSDp56"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382A223DE7;
	Thu, 19 Jun 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337070; cv=none; b=gRE/7zkACOSExe0XiKPsd1foIaiNEPMJoe+d2tiuAiQwcrUKhpyTlgqf5Feb85Li0xHS8FD9s5itRZiHcNSm1eed7nlVPPfmjIPTZcH+3Skh10SM9QOGroaKohxPGILdQwSpXKjEoOLM1e6Pl8ExZb4wTSH6tmGSW6Qej7Q0QGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337070; c=relaxed/simple;
	bh=YScApHOx2uO3lhS8LNVpCGv9Np1OegEyPMaxKqGyqVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlQNa96uAJDLoJg0yw1i4QPB6XiEVxIx0s90t+ZMANTGzYYNkjYEp7x8F2b616B+9nzVZQ6UeiuPxjTpn/8LpYdbOaGQG+n0FPvE3t7urdT3cuWpCuaULv5VJg48qUg+8iOnX4JjTO0p9jZg75mqwPb8Bfq4uuHB2bO6qhA3L5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBNSDp56; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750337070; x=1781873070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YScApHOx2uO3lhS8LNVpCGv9Np1OegEyPMaxKqGyqVQ=;
  b=UBNSDp56Rz6IQQK+YF6WdmNEDN3+nQcejzkcF1JPJ2WwzYA0jq3xszWW
   k71bIc3pCDxkmLJqDySb88ahSgezh37+6yuCkCE7YjRpboke9MwsiKrIQ
   qGBsbyBrdUpRc6dtmJ4EaZ3oehxYG/ycDeQH/qfLja+LE6/7NvTIKGaLN
   nrf7I77UlL4/WHee+193Td4Z9TZ2uOnMHNiv157Gf7cyhesxqupkQKqGQ
   xSLnOU7Pr87v4EMy9m+T94UbItXQ1TjjGXlhF2CVC0m1h3pQ183vF02g+
   +CuR5EcAY2kQjoLFyE+y8GEi+yByiZ9tVTYMPIPyWTS5j8mOl7xO3GIxV
   g==;
X-CSE-ConnectionGUID: 4fAatHjsQLGxcC3UyMzYXA==
X-CSE-MsgGUID: PJWjs/SkTlW0WUrhJR0D1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52453499"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="52453499"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 05:44:29 -0700
X-CSE-ConnectionGUID: LrvhueWOSZ+lEvsaaNeByA==
X-CSE-MsgGUID: Ccb6PrnzSmKixcH6UBlXwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="154653955"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jun 2025 05:44:26 -0700
Message-ID: <d7223d48-f491-494f-8feb-b92a29e9af53@linux.intel.com>
Date: Thu, 19 Jun 2025 15:44:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
To: Roy Luo <royluo@google.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "michal.pecio@gmail.com" <michal.pecio@gmail.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com>
 <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
 <20250529011745.xkssevnj2u44dxqm@synopsys.com>
 <459184db-6fc6-453b-933d-299f827bdc55@linux.intel.com>
 <20250605001838.yw633sgpn2fr65kc@synopsys.com>
 <CA+zupgwLkq_KSN9aawNtYpHzPQpAtQ0A9EJ9iaQQ7vHUPmJohA@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CA+zupgwLkq_KSN9aawNtYpHzPQpAtQ0A9EJ9iaQQ7vHUPmJohA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Thanks Thinh and Mathias for the review.
> Please let me know if any further changes are needed before these
> patches can be accepted.
> I just want to make sure they're still on your radar.
> 
> Thanks,
> Roy
> 

I think Greg just picked up these two.

-Mathias

