Return-Path: <stable+bounces-116338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707FA3503B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D0E16AB78
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7112661A8;
	Thu, 13 Feb 2025 21:08:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFC194AD5
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480918; cv=none; b=c3sIx1Ux/u4v5OEp9I0p6wYYSW9Bg62ik6+bX69s8D5TTeGoYBngdXa5AJ/taAFhbDqdQmn6H4raIIavNQVdZy+sJ4q4NyjiAR88227QifyT8rPauh3YzkC0HJE5OGbOlpv6ht1UC3lOu/dCFpbe/gXze4c9ZlvIj49fF+sk82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480918; c=relaxed/simple;
	bh=L6UisXQphSBrB3t3LpIbhRa9pfTS4AYWSAaIoQb19ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6VU9q31UxMfB6hnkgC1G6jpPgpsVhPlb/GrU4rORShBbr0MnzHAVVJ6bo8nAHobtJk31uA+mdd0yVVFnnCzA6zxI2XUMK8UZOjp+UxZzssSIHmB2MQsNW+zfJnrNCXKK+ETnByCMWr4xBX7GFnxTZUlvz7iP5Ndl9yav1hV2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id E4A18233AD;
	Fri, 14 Feb 2025 00:08:31 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: vgiraud.opensource@witekio.com
Cc: bruno.vernay@se.com,
	lizhi.xu@windriver.com,
	stable@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH 6.6] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri, 14 Feb 2025 00:08:31 +0300
Message-Id: <20250213210831.723789-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250207113703.2444446-1-vgiraud.opensource@witekio.com>
References: <20250207113703.2444446-1-vgiraud.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A backport requires the fix commit a2187431c395 ("ext4: fix error message when rejecting the default hash").

See the patch series: https://lore.kernel.org/all/20241118101811.15896-1-kovalev@altlinux.org/t/#u

--
Thanks,
Vasiliy

