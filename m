Return-Path: <stable+bounces-32988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896088EA29
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1454B3273F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FE1386D6;
	Wed, 27 Mar 2024 15:13:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF86139CFA
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552420; cv=none; b=JlJ8Sei0ZZo1+wpJnDdRe5JG3P/wBM29731ZaztEHVJilLFF+pWfRGw1fKzdLSkX24lmKXg3C9G0C4nFpZu/r7C0uBtfkGxCidOg4CTgTinYh1j8mZiMrku1LIDn5Q47vMFoUMERBqU898xwKe/QZfMI/bVEg82FQrx6UllGBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552420; c=relaxed/simple;
	bh=QKrUzOh6TQqKqjCx9Os/zNETfDaM9WEdSPlZdEVLkqE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=isIE6GuwJyDStqTVB4sFwraVgOZmX6lETKLERsrQaGXuCEuONwdmvz+XpN3dgKxh4ybQth50mxPTsYu0uKELrw+rRiu0N3ePWaCq+UYONTQkQVEmmPU8avQvfzyeCYs0nRNMwhehrp7wnKR1N1slGXeruK0sup1eWhAiO0VpIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B38861E5FE05
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 16:13:26 +0100 (CET)
Message-ID: <3bea11ec-32fe-4288-bc03-8c3ba63979f6@molgen.mpg.de>
Date: Wed, 27 Mar 2024 16:13:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Please backport commit 13e3a512a290 (i2c: smbus: Support up to 8 SPD
 EEPROMs)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


Please apply commit 13e3a512a290 (i2c: smbus: Support up to 8 SPD 
EEPROMs) [1] to the stable series to get rid of a warning and to support 
more SPDs. That commit is present since v6.8-rc1.


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13e3a512a29001cab68fe9a0c12be94e6d42a10c

