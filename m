Return-Path: <stable+bounces-116596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FAA38770
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 16:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A84416E9EB
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501E223300;
	Mon, 17 Feb 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFhixciO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360F1494DF
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805812; cv=none; b=az9mNG0dHVBt5JIEk730OKULQvQZCRhGwl9x5IbMhBGWLN69AzUm2xFIF4fYfbdyardKpdMG6rumNswItA1ZGBcWRPlcUea9H0XI0ePTIY++cC2iRCf+2hWkgEn08gwBJDseHjhBjmxw2BzcnmifjWTWl9d4EGUncEFIonvgecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805812; c=relaxed/simple;
	bh=pDLjIDYFOF2ovSrHz6gtyxmN8db84lQy8ZH4hLsRtr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UXpFNXTfib9Qlg7e80iY8K7lVIvTB/uDYHbpQJZ3b9TRvO+/DsCqLc2T7GeD8ekGAOVhBHFcuy8+ozD23Q9h35K6QSmHDA3EH/kDMnPzX3gGgal/yteyFnsZm108P6kpnEXNj/nkgTlnX5euM/jmGzvP1rxMzM1YJgam8Fw6vI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFhixciO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso292321666b.0
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739805808; x=1740410608; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyp5vpZZcaAZQt+RM5fyX+FLBrpStqFtQpmLdZBWKS8=;
        b=ZFhixciOgTNsyaLOCJ+TTDitiJwq2PD5tA6t3cI/2Mn2x2vysbcfJMi4OrYgw9JF3S
         OkYumfKtSJSt+FRqiAVk+Tjj15Dp+4xosVl99W9C65PfYvMcaO6LfUi6bXyuqxmn12TJ
         6SMRF4m1OYSFWbW7YiKVLAirXgxCHw6WQCJTdZHRVb8vC2yekMDhPmgrGOK2mobwO0JA
         JjVCETdEDpq6XeV5U3GK1OOJn/pnez7vYVsLGwbnMUVXHZiLQ9D3x5JU/YVCaAYBxBNY
         NwIDlROgML+0/t3rrrtj7uw3vITtydVymtWz2HXkzvIUjnxpptgUG8SFFJIkCEarlkqC
         UMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805808; x=1740410608;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyp5vpZZcaAZQt+RM5fyX+FLBrpStqFtQpmLdZBWKS8=;
        b=g976zI+9Bkl5zbT+WTQLVDJtiwvojM6QaEiTEsl3+1C/aCC27Ho9NqowLxRR9pL9GN
         Ig7XevT2kjyHb/fJfQeXjG+2EBaTe/9gznnFZlfpARgjqMWOWBO4XAXaqstKN0Hvjb/B
         z3eGPO+zMi1mb890HStuDLFvxN5jdIghtZSLwe1cXEj7Vh7VcS/DT/1D8yTVltaR+tib
         YlbBouG3xRUEozTGA/v8lOGBQCAeiPvjUpBAt0qJJdgo5pPPtlmqyrH+q6Sm6RHp++iR
         SIPDfL5Ce41fOxff9o6FgQCoUcQC0Vk/WhhRVyg6lKl85MkMo04fhbSZs1J2YgZy8iaJ
         PpFQ==
X-Gm-Message-State: AOJu0Yy9R8UFfJ5ygFT0LJQE81WwkNKId9+mkG9YItQoQqcrwaWq0lGi
	V/53NrQ1lfvuVYRTfe4I77Rm1V4ShzZu8edK1HU+k+Z1wN4gAzla+jVykA==
X-Gm-Gg: ASbGncvKNl7KwveBK5UMIjrUKEyYySGNSexFM/wWaFHK7lIIcupvmLOg4U4iRjDm9bR
	s2DH7Z7kWzCfFWxa/iVe8VQN9+xxXW3cA2EDx1OTz82PKqpRFkDKa1Kmgk+1LXAl6mDQvsRZJvE
	bZvBNX6S3VYPji53JQn48Ibmvg2N2duF5u/JnQQgpU7TyjXebGoZ71vbbVsSQ49qnCc7LsaBfyo
	am3Lv0Mo/ytVtdmD+BIDRUrx8F7YBh2NId/k+pFGCCYZxilynyvscZYS68D4V+hNgsWlSXeXAMJ
	3CvK0HErdAX3xevNI9tRN8fbljXGqUIJeDnYIw==
X-Google-Smtp-Source: AGHT+IFy3M1CrPyFok2cWpBzBfgZD1++/9it/izMXF5BlAANhHPn8kJZOJS5cZILNQ9FgFKIPGYa6Q==
X-Received: by 2002:a17:907:7843:b0:abb:b36e:5350 with SMTP id a640c23a62f3a-abbb36e569bmr20228866b.44.1739805808143;
        Mon, 17 Feb 2025 07:23:28 -0800 (PST)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9654a6b2sm265220466b.135.2025.02.17.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:23:27 -0800 (PST)
Date: Mon, 17 Feb 2025 16:23:26 +0100
From: Max Krummenacher <max.oss.09@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	max.krummenacher@toradex.com
Subject: regression on 6.1.129-rc with perf
Message-ID: <Z7NUbhkfDZeKeIu9@toolbox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Our CI built linux-stable-rc.git queue/6.1 at commit eef4a8a45ba1
("btrfs: output the reason for open_ctree() failure").
(built for arm and arm64, albeit I don't think it matters.)

Building perf produced 2 build errors which I wanted to report
even before the RC1 is out.

| ...tools/perf/util/namespaces.c:247:27: error: invalid type argument of '->' (have 'int')
|   247 |         RC_CHK_ACCESS(nsi)->in_pidns = true;  
|       |                           ^~

introduced by commit 93520bacf784 ("perf namespaces: Introduce
nsinfo__set_in_pidns()"). The RC_CK_ACCSS macro was introduced in 6.4.
Removing the macro made this go away ( nsi->in_pidns = true; ).


Second perf build error:
| ld: ...tools/perf/util/machine.c:1176: undefined reference to `kallsyms__get_symbol_start'

Introduced by commits:
710c2e913aa9 perf machine: Don't ignore _etext when not a text symbol
69a87a32f5cd perf machine: Include data symbols in the kernel map

These two use the function kallsyms__get_symbol_start added with:
f9dd531c5b82 perf symbols: Add kallsyms__get_symbol_start()
So f9dd531c5b82 would additionally be needed.


The kernel itself built fine, due to the perf error we don't have runtime
testresults.

Best regards
Max

