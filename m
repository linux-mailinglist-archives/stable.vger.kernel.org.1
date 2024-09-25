Return-Path: <stable+bounces-77442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B7985D48
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3231C20924
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446BF1DCB2C;
	Wed, 25 Sep 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecVK91w/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29341DCB22;
	Wed, 25 Sep 2024 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265792; cv=none; b=KwPMgBHlbjCVj86vCbqP/+/GjnpXxtXCak92XDg2RSBtB/fya/Tz7gRjJafIJM51I1BkrHMm16HVlDnN2ZvyTR0JNCRtO84jNbxwTgKeM6nvywB+TZl9PULIF3Ckcm9vTKJKjNhmc/j33azufDl36/sOVAtfeFbaNJjY3bJLvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265792; c=relaxed/simple;
	bh=/xV6SQJLI67BxldE8hVKjgn+weS7sgiPngv/pOHfy4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTEKfqHewyGi0F8243gcPL2pOq62Kyepb4ruqyXwkS+4GAPTwHk2MvIKkhS8iIE+ejUf2IdvqmiMztVEsxQNKvVFYEfrqFfzVGUKJVHgJHWDrPzzdLRjNA1WM6iRpJmkrSuLLha00QouMA8mLyRfej9QGMN0AVUjNOnJV8w7CZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecVK91w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F3AC4CED2;
	Wed, 25 Sep 2024 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265791;
	bh=/xV6SQJLI67BxldE8hVKjgn+weS7sgiPngv/pOHfy4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecVK91w/E6VdMOEymf2z7ylongMf78cRBrLS/iYkdb8Ozyl9iUfJ43nCuaVeqyDKg
	 cmbrpdix9m+i6eETfF2WKtObKCqf1ogFnQW2ZnqKVThoase2v5rXnKPmObCsPHFiI0
	 ZPQM5uu3Uf20OKNl8bKnDIETciK8RnQ8niIIgRIw/OcX6J27nyTqlX49LVhJsW91s1
	 sggTFzZpfxTnvutNEwk3LtRjKYHcj7vE7pQuJR84VAI5/krcU6ty/fbrPfZFCj84qM
	 sZhNfPBtjtCUjhBoIplkHxUoyK1FT209Z0A76snh23PSp5oh9bYHhURopl8/oXHlux
	 kBM6LWnmfmqbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Denis Pauk <pauk.denis@gmail.com>,
	Attila <attila@fulop.one>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 097/197] hwmon: (nct6775) add G15CF to ASUS WMI monitoring list
Date: Wed, 25 Sep 2024 07:51:56 -0400
Message-ID: <20240925115823.1303019-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Denis Pauk <pauk.denis@gmail.com>

[ Upstream commit 1f432e4cf1dd3ecfec5ed80051b4611632a0fd51 ]

Boards G15CF has got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

Add the board to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Attila <attila@fulop.one>
Message-ID: <20240812152652.1303-1-pauk.denis@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 9aa4dcf4a6f33..096f1daa8f2bc 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1269,6 +1269,7 @@ static const char * const asus_msi_boards[] = {
 	"EX-B760M-V5 D4",
 	"EX-H510M-V3",
 	"EX-H610M-V3 D4",
+	"G15CF",
 	"PRIME A620M-A",
 	"PRIME B560-PLUS",
 	"PRIME B560-PLUS AC-HES",
-- 
2.43.0


