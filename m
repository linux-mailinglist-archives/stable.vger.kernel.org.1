Return-Path: <stable+bounces-185630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F2BD8BF7
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA31B4FD205
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD52FB0AF;
	Tue, 14 Oct 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZC3gkKSE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54102FA0DF
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437418; cv=none; b=YxMPvb3kHlQDTWPiZQfZeQtMrW9csAKnBVhsqfCnm5S+tWnVrL9qisa9gMmJcbRrQ1WJaHvb8qrqxEV9SPExdIyo6whZJ7VRkJzIInvIBc7qQ2g2h56xALYXeS2eRATzNnEoZCGaLuqw7Q2+nRPAQk7QqLB8tvcjMPFTmkeEWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437418; c=relaxed/simple;
	bh=F7iiiWJil8lr5Lg9OzDGeEMXA53iTr+8fK8leVqtgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbzaFyVrV+kxeSckbBPmMiRn73eMjyi5O6WWMCoCAFWo2u8+EASp9Y/kIyxEFOgIE67U7nD0FJYBqNBD9zz/5Z0s6GKkKzpNPXHGcL7psa5QDbDOpowUgutflfKFHjZOwgJUncRaShYIUYUcZ4RmrGxwLnfPsIS4TfljMctjZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZC3gkKSE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4602110b3a.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760437416; x=1761042216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvbagg2IA/uXkd0ZT7M7sfHL3n1Y94M8PIPHMNkPsa8=;
        b=ZC3gkKSETaikfQDjJqShfBhmNClkRR0Zegvauv27h7UUWm1O3jYeQQF6O/Def66212
         jihxKVyINcs+VguybUsd+O1UF/GmzodogA/v0ToBUpG4rN8Fv9Pa1YeaSR2TN2pgaIUH
         jglbEweCEzG+AV+uukz9KpuNPoZUhw5xsZACc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437416; x=1761042216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvbagg2IA/uXkd0ZT7M7sfHL3n1Y94M8PIPHMNkPsa8=;
        b=vLwyyDIsFaDpAHSTpg1MzgcN/3stgG/g9op26StlpN6rCLyBxajyUD5CISqkropxZ6
         UN+o5wG3Ww/W2GyHX5IV2/R6QCDCn5PVCrfCoP02c8NS0F5mGWJcnzE7fotz6fbv6xHB
         ThGguxfAoVnPneZlFnyiXYL4jz9Ox6iUnmEXlT/Z5GY8o6RJKpOsgs8CDBAy128yChhv
         +1QB171fjiLotNVC3je3GANj0r6dUCY8M3jJi/ED8HQ+VoeAo1/+4jwQB3jRR0drvnJq
         dO7sXSQPcwh6lsQ6oft4garPGm7LfoEmy0czAPB3vUtq8dayrL6dxbgi+U1gRPDLVgHT
         faPA==
X-Forwarded-Encrypted: i=1; AJvYcCW8GHbzJ0b0JZxzhlFF7Y+FLcxg/rWaXNrxAwsdUF8KEGj3r06fQUgjv3YapV6VriYzXPQEPqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5I3GO8Kb5nNm71UAkt9xqvTSmxpmcYEh4vSkP4a6d0IOg6cb
	/UuZpDOXRGxGDK43Oa+nrFN9gKFRAeqvAoxGvgdPQt6bU2Ngjbxb5yF0zKK2dc6pxw==
X-Gm-Gg: ASbGncu71detf7PpakFL7gI25OVf01t2sav1NBBpDA2v1G5vPEXKZs/ZJE3AM8Ahe6O
	Pfasdjj7DyhvW8HbgsrJmxbRIfwS3xwIEQWvZkozvXqxZrcU2PQRWWxmzx447+aR/uco61XJsC6
	dsggS6bA9Qm2k0sUAn/34iurLZbs6TGbK0pxSZeVd5b/fi+EoO2JEXOtRevFV6cWF3wSzNmPBTf
	dWr/3kVc9cUz9FxA56jiZUk2XViuj+RNdcO8U4nqtS7xTu4l5peu+4g9XzP6P7tuPVrYpCBX2IS
	G7e82cTiAuaH4TCkUm1283VJwl79PvPJfrKedVzHUnY7u8O+F2JNQ8comFQjv1K8nHE9mjsHOCb
	j3LrS3YbPTSO5/2kYDRfqilQ4hIVINc0MOTEy2+rdqZ4B7gzm+YnVKw==
X-Google-Smtp-Source: AGHT+IGASm576xQ/Y0lTqK/5/WEa24uOVhXlkqIYz6pqxQzAQiPqX+MD5xHt32UH00HFngJv6L/bsg==
X-Received: by 2002:a05:6a00:2d8f:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-79385ce2724mr27606408b3a.10.1760437415991;
        Tue, 14 Oct 2025 03:23:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm14398178b3a.54.2025.10.14.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:35 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:23:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>

On (25/10/14 10:50), Christian Loehle wrote:
> > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > invalid recent intervals data") doesn't address the problems we are
> > observing.  Revert seems to be bringing performance metrics back to
> > pre-regression levels.
> 
> Any details would be much appreciated.
> How do the idle state usages differ with and without
> "cpuidle: menu: Avoid discarding useful information"?
> What do the idle states look like in your platform?

Sure, I can run tests.  How do I get the numbers/stats
that you are asking for?

