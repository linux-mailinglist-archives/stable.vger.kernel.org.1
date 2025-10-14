Return-Path: <stable+bounces-185591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A7BD7FAE
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BACF64E7CFC
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C02989B7;
	Tue, 14 Oct 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NksN+hxK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396522A4DA
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427831; cv=none; b=bTblAmx++WbBdLvA3dvkblXcZlYxYZEmv3vDe4i/ZocQEzqUACcQUZ8tPpl8/D4ro2+6SxHuWPYbynKOFJxYCWHBdP3vKibz2FP3hLWMvRQQIV7Q4UvkEVUJvFTk8s/2vL9EJEaO5X1MLArjR5nMdrMKBbQbeq/2bORAA1EYam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427831; c=relaxed/simple;
	bh=5XIOTuXhcfgvMyryjkrWnOKtBwIw5u4qV0qabQznBgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOhN4GhVGSe1dxWf3mqrKMLt57aEsLAFC0aA1TDGIwfBUFPaZfo/tIhiSg0lzKjS7FqoWUzz3QTesWX5TUekGRNDKHJnBa4pk1ynlJ+F9Q/lQO4xCBSYmwNKXNU/fu3giD5UAE0sHy0zM9+q6SSsAQelgnBcMC4iDMRn2bTnmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NksN+hxK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781010ff051so3568926b3a.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760427829; x=1761032629; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DlbE9d0672+FMSDbkuv7W0GPOS3Q83G9ePLSrqsDOM=;
        b=NksN+hxKLeRHLLpxmy7kf/1BCi1nudO+y+Chk7V8qgehN8PwHKRjbPvsBxHpGnb2Hl
         yiorbUOgyGHRcLzxQukCkUlvFDrHW51kFxySNmpJ803W6JNWGY504dmB2AIo++eqFucm
         QvU8d5ISe15jsZf8kCnR8d/vgwsscCWSGzgKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427829; x=1761032629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DlbE9d0672+FMSDbkuv7W0GPOS3Q83G9ePLSrqsDOM=;
        b=Bv2Ap2OcYUi28lUZRKgFxhhzO9LHFzA1XbLhVlmrqdV+KRiXdupDEruAoxNC/RtRF1
         Ax5WEt3XBODGQ665i67CjdJ5rw8Yw0Yn7105DiPzq4N5jXpfuUzTMmsNhBZD6oR97BJW
         HiPXtswemQtKD6PcGoGRmU4Xy2qSO2rGLrFclrqQUbIizO1tuoX+5Kwge0WhMutj7GhK
         UQ+SvKBPbospB5Hka9GzBMC2gtP3tTjItwTlrfRRF868JhS4W0gXBM/v6usiHG7WzNq7
         nh7dVcb7M+Eq1dfECZ8Ux3kVEri+4A7U6KY85YRpit9oQ3M3eAw92+0UJYNstk2QJCGz
         PEWw==
X-Forwarded-Encrypted: i=1; AJvYcCUr+5I0+ItBnCb+onG0GJJRkbAGPwxD9Mm+dT44bk8KgxjZ7pcb2TRzbWJ1qOlhdz6pvfxVk0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbnUZ6qWo16QUxZklGEBifKDow+IM54xY5Ziq2Jp5a24C2eGh
	TtcCjs8AOb+NgnVwK+p02lYiGZm6OUL9UmHQY2wVfOUnqjcuW1DB3ZaGKMhRwFUIaQ==
X-Gm-Gg: ASbGncukT98ZWVmv6nRavOFmofBX25zeX7Yn9c0Du4tpDS2n5L9OmexHkBzNYV/TTn6
	EHnqO+EZ6h3QbOOfcC/3NW0qyzjnZHVRDw82+Gdsf3wOdJJJ5jdOkdU44VPF71Q233UKvgRtn4+
	6gWJMmobV2SwNt7pG14oZcabykMjKTJoXEHEIR20klfWg4pEFP3bO6FDqQhsfln2hDQ6rSd1RFP
	zb/sWY3ZjPLIEF+qcDeOJjMOPRYWCSSAchgWzah34Icuq4FWUTt9zF4PIJrUJenMMPUpNgQfw3i
	7c1UaU7pbutyO2L8kec/Rk67Bl4e3NjzUBycOAUeCloRWycNJqdsxhbDlsS0JVf424ROD2Zr4AI
	G5aC9vUADZyx4fSuTLfOTyCTEY50wyd9RZbt6zFzvfWDI5qtfZ7tUBg==
X-Google-Smtp-Source: AGHT+IE0JPbH8RFvmKwtEh2tQIpvat5nn43ulCK2cRbdX4/desLZYKw49GjSVt+mBH4CgFZZKXWYLg==
X-Received: by 2002:a05:6a20:3d94:b0:2ee:4037:1df7 with SMTP id adf61e73a8af0-32da80b7fccmr27471304637.7.1760427829259;
        Tue, 14 Oct 2025 00:43:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67af9dbf32sm7952404a12.21.2025.10.14.00.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:43:48 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:43:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	stable@vger.kernel.org
Subject: stable: commit "cpuidle: menu: Avoid discarding useful information"
 causes regressions
Message-ID: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We are observing performance regressions (cpu usage, power
consumption, dropped frames in video playback test, etc.)
after updating to recent stable kernels.  We tracked it down
to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
upstream commit 85975daeaa4).

Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
invalid recent intervals data") doesn't address the problems we are
observing.  Revert seems to be bringing performance metrics back to
pre-regression levels.

