Return-Path: <stable+bounces-83307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E81997F7D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2BE1F24F16
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54061AF4E9;
	Thu, 10 Oct 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UazkOVcx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501819F48D
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545513; cv=none; b=lTpFT/tzgnj7Xu1M1y7SCNYYuPapkpq6QoOcNkyt+hkJAP136WJztM1oaHr8Wj5QXTeSRZAzU51xVGJ7+ELen4BrnbyBiUF1Qfk+Hw0MjC8xXba5HJNem6x+kRshQEn7avNmuZ6Dw4JFhppTCDf7ZcnLKOyu4S2jbfpWaIcdGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545513; c=relaxed/simple;
	bh=uPWbzX76mHqG5qhPAIxrGWQ9jJZ332gBiHSuu3XECsA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qmyg9I/v8zsQcLG/nPvSahBtrq3MvJuXwXxeYydZRkSY2Mh+pLhTFFT5LmyhiEiCXUx3mENH6xzu+fEn9ToiaiqCjEv44PpbsMaRFw2oA1whItYRMMKDLWqkrkrZV4g0/z3TkPqd6t5ArOoSkpU6MMxp5HrjVgguSoKGpgZUkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UazkOVcx; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so95480a12.2
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 00:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1728545509; x=1729150309; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPWbzX76mHqG5qhPAIxrGWQ9jJZ332gBiHSuu3XECsA=;
        b=UazkOVcxyTRb+Kt2/c7YVEq/Kd1uxaJ9Fx50i6yLuHXugVtE6sp5xdLU/xwVK8xz4D
         j0jjtUVmjZaKbYTKfHElhH/hV+YcrmMi6vuOn8lvLSUWSZZ1ehRkxOWZUpAE/z9TxinX
         WOX2lDx4yESvvmPCgivrlof/+3jjNDkmJQLgnbZjsbpgu89N4q0lSggkn7MKN4dtU+Ha
         9jsGDDMriK6W+XMmYl+IRxD4V7uYH7F0wqtx8J+yjGwLoH/owIKAzPwyakoMXVAyGwsk
         uBChK4/TvgfzCE5lPwMLF6O6cr7XHkUWialq3CjFhOxhJ34ecwxXTYWOdmqCnuQVfbKf
         7pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545509; x=1729150309;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPWbzX76mHqG5qhPAIxrGWQ9jJZ332gBiHSuu3XECsA=;
        b=R5vfc+tt2vIoeqbdZcklBqs/039zUTi8nyWYNjC0Qor6raRyG1v7sbC1J97NJljMg5
         8hnxKB4OBIhK1UxRHiV3Brwb2hyt/NcaXgfgo5STvAs3YNlGNqXDyaIajJmBRYVIjerd
         gxLrNBbRL1Jow0OvYty5fjWghhIzNVwqrQklnZ/J/dphPcRU8yClvi2oZKOp9TjitNfc
         PTVDMIqR3jxT83+p4dfs9dvNeHLIlNlFbN/wpQ/yW1RSDOM6Y2mkaTu+vENLS3khc8fg
         sIGqv58nWVkoAEyx+hzmFvDbY3VdjEfw8ntBmZKT0P0B+YnJkmnXgSqdq5xs1bZ+jZLj
         7tGw==
X-Gm-Message-State: AOJu0YwPTwuZlNr1b99V5xl9tKW2/vKCPy6xPjDDK3vnk+QivJHy7NCa
	bzOmMlOS1w40qUEo7CTCQ2iHwIaFQjQX7wJuiuPpCJp/1p42g705zQB/udbamGCS5YqOaMQ2m34
	yWdK+QmPDmWAKbZD8S1aoe9ZZpeyCu41ZL0+P7V/SEVudAdxKXsVbWwYP
X-Google-Smtp-Source: AGHT+IFI1CFd7gW+BcYjzPEi3ZyOAvrdlHxG2brM6EwMCnpwAur2kdYmSMnPffs29jKvoDGOtUkL4EY2DQe0WFca5Tk=
X-Received: by 2002:a05:6402:5112:b0:5c6:cf72:fca5 with SMTP id
 4fb4d7f45d1cf-5c91d5980a7mr1530923a12.3.1728545508642; Thu, 10 Oct 2024
 00:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 10 Oct 2024 09:31:37 +0200
Message-ID: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
Subject: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770 and
 Intel Xeon 6710E
To: stable <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	baolu.lu@linux.intel.com, jroedel@suse.de, Sasha Levin <sashal@kernel.org>, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

We are experiencing a boot hang issue when booting kernel version
6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
6710E processor. After extensive testing and use of `git bisect`, we
have traced the issue to commit:

`586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`

This commit appears to be part of a larger patchset, which can be found here:
[Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)

We attempted to boot with the `intel_iommu=off` option, but the system
hangs in the same manner. However, the system boots successfully after
disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.

I'm reporting here in case others hit the same issue.

Any assistance or guidance on understanding/resolving this issue would
be greatly appreciated.

Thank you.
Jinpu Wang @ IONOS Cloud

