Return-Path: <stable+bounces-61851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B853093D067
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16371C2117E
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED417557B;
	Fri, 26 Jul 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iETMfKD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB9A3D
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986133; cv=none; b=QsbvGEboX/eBrariWv8id6acSBz9Gi208P9mCfOsdkX8H0LZds1fsr1MEgOXZTaf08BaVPMhRFWPToW2aumbS05eimDu2cudGbX4IQZMncqgio/COQ+We/JmZk6ypwyx4fJJ5B7ZlpqX5gO8PgdKfidoSZgg9BYMX0idYWh43lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986133; c=relaxed/simple;
	bh=Qa018Qdm2ZCVpPUlgwOrF+mLxIb/oDMYDZjhhaQwI7Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=umEKKR8yZDXmtKLSk6jqzouwu51aspFY6vgGK9gSgW90yY2g8HVHnSMEwoRriaQS/AhT0iP1pbahGkYbXiWnX+WxOZcnuEIbbrUvLwAYpZnqYYihmknWYX0+xqDQTvjPFW11wkgf3B4oa5ZMcCAquJX48Ue2tj2umz1MNu8lFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iETMfKD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FD0C32782
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721986132;
	bh=Qa018Qdm2ZCVpPUlgwOrF+mLxIb/oDMYDZjhhaQwI7Q=;
	h=From:Date:Subject:To:From;
	b=iETMfKD7uFONQAmxJE717AY0mWMuGOwVhl9ZAtfv/6BdSuI3b/+dtGu4jgsm0cuLt
	 cUkj0aPCZDP68z1PIMnE6NYTxCrE4zELBfclxmxT9RmnGjIAbWOq9z6D3oeasl/2p2
	 QsRgPKr8hbFqLZGtgdf9KEROE0d1C0baXjLsJxIIX0cMhAmk6P9R5F+zDsyUHIkzql
	 wlp0r6lvj0hU/IkGp6Pl4JMayY5JtpBo4Hgj8d1T2CJmcd/XXaQsC/gX//Af6aZWGp
	 Zt3yu0ZuERlbkS1KQhijgriBgOg0IJwVYTmkN/Re948a+6Cyl4B559sBk1ZmfPjnGK
	 WHJHFcvytrSwQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so12747291fa.3
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 02:28:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZrkcQn3ogJChUUhzIEBoz2Fjdgh12+rFgNTb0vzG2gsyqoI6v
	RzpVn8mUolistSADtOpYPNivnyewO2OELay+WjcZkiQxXv4rSo3X6meBWpz5zpI34yoflh2bI9x
	O46HCwSIkd5z6+9ZXXN4J/aiww8Q=
X-Google-Smtp-Source: AGHT+IGAk4c0AncyJR3y1stMNZsWMoVPRMXFwLUzBhdnuwk7z3Cq7z/0joDWBDhDXsvSW3TI1E7daCkC+ejuPnZfunY=
X-Received: by 2002:a2e:a78a:0:b0:2ef:246a:e253 with SMTP id
 38308e7fff4ca-2f03dbdf882mr37781741fa.37.1721986130076; Fri, 26 Jul 2024
 02:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Jul 2024 11:28:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH7oTmmxpwO0sFLuEpGY3_3iSJepptV_WOid=w7+PhSXg@mail.gmail.com>
Message-ID: <CAMj1kXH7oTmmxpwO0sFLuEpGY3_3iSJepptV_WOid=w7+PhSXg@mail.gmail.com>
Subject: EFI backports from v6.11-rc to v6.6 and newer
To: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please consider the following patches (in this order) for backporting
to v6.6 and newer.

fb318ca0a522295edd6d796fb987e99ec41f0ee5
ae835a96d72cd025421910edb0e8faf706998727

The second patch addresses a regression on older Dell hardware. The
first one is a prerequisite for the second one, and a minor bugfix
itself.

Thanks,
Ard.

