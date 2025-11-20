Return-Path: <stable+bounces-195225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D182C72340
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 05:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1138F29A81
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1745153BE9;
	Thu, 20 Nov 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqc7BOZo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10E1A294
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763613949; cv=none; b=SpIoJRBqw/B/Uvku9pUNGykN64jG2Lz/kR98NIW9WhnsR656+fyC/OwcPqAMcS3yWa0/cSkb7bgKPhlnzxBOsoyw3XoF/LbLC66p+A4mPJ5ZOuMvTND6MOZ34BYXmOWJFLilSvgpt2qFCHJqx7z07u4e4Sx4A+IsDI0Ns3OZuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763613949; c=relaxed/simple;
	bh=tNuAGLHpwPqBv4x5RWVvU4mnerMM3wfngMRCI9Z51GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/4aUbg2J427dUdW5RlLXUqhswQVytLzk2SmhxER/iJUBkYt+alRIvSKRiTXn+wzu7hacx+cmvzdNTERmDgcmWLsMUZoA2n1xIIA555HjUPtktY/ZZne2M2BxEXIoRSjR4IkOg6q8QI1+pKzFbws80yVZVlbeRSENAqZxxU3kDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hqc7BOZo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so340687a91.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 20:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763613947; x=1764218747; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4csVDGQi0uzI7KXFvmFTROpehQUVFhpuyhu7CkMbL2U=;
        b=hqc7BOZoR6V+7CO1u5NWDvPCVnQfd4/wwfT7h0d/dGCesCzZKwQRf/I2v1e+mPK0H+
         XLzwETf1o6alU6AH2vcHy/95oWf28HniV+oxooLC+4QdjPxDSqFLsfFm/i/jXVmcjkON
         4SGQqHH+38MYhodFCHSZj0OIvMaDkxrnN0kmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763613947; x=1764218747;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4csVDGQi0uzI7KXFvmFTROpehQUVFhpuyhu7CkMbL2U=;
        b=FdxLfclhirU1tfJUuMTMT7oexhujbhi8Wu0cxdfIZdaySkedtsejm409pVw1Xs5JFS
         ktSwRgh/g8LPyZUWFv/TCBzTylAI9/6ufV7pxyuy6R06c7HAS7rgsXgXvVFS/wpw5Ly3
         LoSrh8KwOVRJ47I8seJFoNGlC90r9EFHCX7toRvJFUpssNiDI95juW4f9onIVt6J1urj
         rl42MagFZwRt4UiI9IZwyaVbOUs1eG1JNrQQggop2XMtx6FsJEjnGaKtY3H6/mVPUORA
         p0zq/bHA5ZQ2BDyG2ctWO1UqIJUG4/rteoH/DMAFO5FUPr23lZpEf5LTkjJcIdZPvkw0
         7FhA==
X-Forwarded-Encrypted: i=1; AJvYcCWrzXzHJfbJlCRrWTPN6yoP2diuH1Xc6QcwCumRlChSgQ6MBv5uzUhnG00qlptAPSymcd0R7v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIuq6cOgNkpW0Z+YbVEw3Y0RSnScgis9YFSiNx6mT9FzXe3ik
	vDLchbiZsTZ6/mRpL7yFfaUJs+NiNwxFqHEobDNA59wh5EIyL489GwPr+633wANAew==
X-Gm-Gg: ASbGncvOPFdN/4PjpWPXLIf2KMDTfjc1UgImkA7WBwBOcOqMkrsYasuwjobrgvjxjJn
	9uSYyuQHrYjeUlyRCbuZNAwETeIts3mlIn2X8tkfMPH5kKGiNERj24lwTrQ8GekKorWZMxWSYnF
	G13MwYuExsKYHHozQzBMX5okdItZov4MXjnRgYX0BQfrCZvtJcNAp71PRP7OhdJkPWMLiMsP8y5
	SZev1RiKidy86SG6FR86+qfKQ1SdbtjWgBBMgWh4TDzOlxjmF3ZHe7D4bXxWN8HXw6hRHCrE0lJ
	btmz6/N+IltFkUn0BmQ31sn4wqarIJNOVKRJy0PNnb+CP6PNVumIVKX/udFHnRYTCknf45MCS9i
	1TWvrWT21mv9lLxUjvFEkCGhEYvUapqoIXmnnYgPt6pu31kWyMPyqi0qEaRpJYmKg+DW7XGbZ/a
	7kQg+zN3KRYo1URoE=
X-Google-Smtp-Source: AGHT+IE83S5WPqoVOxTlsmYoJYXn0pYm7LRkbtzXmy2+9sXRVSXiPydiB5UD2ENbkUfqj+ICV8VfDQ==
X-Received: by 2002:a17:90b:2f44:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-34727bdb84fmr1856728a91.10.1763613947454;
        Wed, 19 Nov 2025 20:45:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6762:7dba:8487:43a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b04f3b8dsm2908936a91.12.2025.11.19.20.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 20:45:47 -0800 (PST)
Date: Thu, 20 Nov 2025 13:45:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yu-Che Cheng <giver@google.com>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
Message-ID: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are observing a performance regression on one of our arm64 boards.
We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
Rework schedutil governor performance estimation").

UI speedometer benchmark:
w/commit:	395  +/-38
w/o commit:	439  +/-14

