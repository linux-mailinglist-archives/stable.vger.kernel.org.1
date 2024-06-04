Return-Path: <stable+bounces-47934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8028FB689
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102421F21FD3
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88414388D;
	Tue,  4 Jun 2024 15:05:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1A143C59
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513499; cv=none; b=j+qwfTLVG79AOZE5E82YsjEnLMnrB97hgCSRad+s/fnBzfqclPwc6zkpIZCdJOoh5zG8r96gQg+C5XIgXtfUWlp2c8tfv3CsqRU9tW/3lnk3ZQvYPF0rguvppFFCOu/FDioS5fN/mLiY8GmhEx/6tZmnRfSF10KGAk4ZWULTQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513499; c=relaxed/simple;
	bh=oFAGtTz8Iy8APJQcOqkUw38BhKHEdE24KMCCcAIft4g=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=F8Zy1iLZGI5dYad5i4IvCogfwF56htw/iKoFANgxpinIcNpdHoI8JpvKt9l1dpDtahgN8ijAnmpIjCt2ZmvYu3zrijQbJ7Qa/6Dmu0w8FT7TuJYXn6ZlJ85TSwLPdaOpnAL4K6ut9W17NjR3+KLZWxgw+E5FjgxnRjTaTlfOwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7553.dip0.t-ipconnect.de [93.221.117.83])
	by mail.itouring.de (Postfix) with ESMTPSA id 234C110376E
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 16:56:25 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id D76F6F01607
	for <stable@vger.kernel.org>; Tue, 04 Jun 2024 16:56:24 +0200 (CEST)
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Please queue up f4dca95fc0f6 for 6.9 et.al.
Organization: Applied Asynchrony, Inc.
Message-ID: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
Date: Tue, 4 Jun 2024 16:56:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit


Just ${Subject} since it's a fix for a potential security footgun/DOS, whereever
commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd value")
has been queued up.

Thanks!
Holger

