Return-Path: <stable+bounces-208209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9679D163E8
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 02:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A09030084D2
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 01:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA22BEC55;
	Tue, 13 Jan 2026 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="e/kXAiTx"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E612D1F1
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269466; cv=none; b=fKIzl02M1NMns5RykpDfhlSgFoPO8i6pw7Dps7DbsRmnqpbaoZBjaBwyOZf0HJ+KIQoHKRWsXT0wJQh98zbDzP9OpdGnmdOCZdNacDFX0XC+Xb1DHeuNBX20cE04W/2p0hT6sJ/5wNXObQ8+D1Rt87s7tmVZQirLgJVFkuvzMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269466; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=EWA12Kg3H+F69Sw9jGARwRoBGdZeqX2dENSX/iDOcKxEcQ8WwK+Efp46JOblWlswlKXlPmTlmmxUvgzB0wyueuxN5NvUI/llsLz38nkLS+uQAyW0D9bmP6HTtGIN571cEylalTAuKFYJNyuwu/qzCUVSywbJFwV66DRPyozIElk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=e/kXAiTx; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=; b=e
	/kXAiTxarQ6uzXUBZd3k/e2Xy9RY3uCdqApeiAPgvytMUK+OV+CyW7GWVcjFJ3gd
	Mth4n0mlZ/QffhZuYUmzjbtLe4Yj2iA6bbq5fq5w4owAzF8gHDfRNLvOeiNfV+6n
	FBxnruESnYzX4Y4NNJ+EXX0RU6pcOckVpiFMYAGtSU=
Received: from cp3alai$126.com ( [49.7.65.243] ) by
 ajax-webmail-wmsvr-41-107 (Coremail) ; Tue, 13 Jan 2026 09:57:33 +0800
 (CST)
Date: Tue, 13 Jan 2026 09:57:33 +0800 (CST)
From: alai <cp3alai@126.com>
To: stable@vger.kernel.org
Subject: =?GBK?B?wLTX1GFsYWm1xNPKvP4=?=
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2dCv6dtkwu5SWRbekfmUkUjus3WMKyuv4u34RQPpF8jDrjwg4aTHFNLVTZ2dCFLSqMiTaGVSZo9+Z/T4RIYKUOsJhK/HWEQIJecoXb3dTkxQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <48952fc2.1661.19bb5129933.Coremail.cp3alai@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aykvCgD3b+6NpmVp08JDAA--.21079W
X-CM-SenderInfo: lfsttzldl6ij2wof0z/xtbBrQ2APWllpo2cnwAA35
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

subscribe

