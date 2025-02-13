Return-Path: <stable+bounces-116340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5AA35048
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D634E16C373
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051D266B47;
	Thu, 13 Feb 2025 21:12:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA56194AD5
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481148; cv=none; b=ppZVSvDLVVWfDkj447ZUv5UcR2Y63LASiTOXCHPIPaIMCZCTtaMoxQ7hkr6nOqQLqrjSRccWSxoeoyswF5bJzci7SykcQYa7B1IYkhjI21xcXDIfj2f9BWjiPqdJNdFtl88PMUnLey9bg70K2zEDCbvv8FMXuyZwg9CjgaM5llM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481148; c=relaxed/simple;
	bh=yPgYvvLE0GpVLfK9789KsHcMACK4gAuVj60fl61Ei1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FIzA3Rjq+H4/dRtr/WVtPVR+PI5wlu+3hhkuNe3Zj6DNYru6oAwKo8UoTonDBM3OTJz+2kX0TRBjBLquz1NL6ztQ4mm7beQu+lpNkr6iRMA9wkHT9uvpQJC3bnu7wEuO7bX4xR6qyUX+JLgealllEH9DDSTsQrdkO3VjEcd+AZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 2EA63233AC;
	Fri, 14 Feb 2025 00:12:17 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: vgiraud.opensource@witekio.com
Cc: bruno.vernay@se.com,
	lizhi.xu@windriver.com,
	stable@vger.kernel.org,
	tytso@mit.edu,
	kovalev@altlinux.org
Subject: Re: [PATCH 6.1] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri, 14 Feb 2025 00:12:16 +0300
Message-Id: <20250213211216.723930-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250207123926.2464363-1-vgiraud.opensource@witekio.com>
References: <20250207123926.2464363-1-vgiraud.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A backport requires the fix commit a2187431c395 ("ext4: fix error message when rejecting the default hash").
and a prerequisite commit db9345d9e6f0 ("ext4: factor out ext4_hash_info_init()")

See the patch series: https://lore.kernel.org/all/20241118102050.16077-1-kovalev@altlinux.org/t/#u

--
Thanks,
Vasiliy

