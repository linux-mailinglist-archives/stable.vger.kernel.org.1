Return-Path: <stable+bounces-169801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D5B2858B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5287BEB76
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE231E51EB;
	Fri, 15 Aug 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hFfnlEQF"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459463176FB
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281304; cv=none; b=VeEkq/KrN/9jCScXnawMUse8s3dgBcSV4q+W7yFAwTbM/UqQmPOJXKELI3R4nG3gkF+5v/aoBZcSIkZFI+OO7JkXDggNX1KGPLKjOigcv70em14rq3cnvcBnnlmNyq214o3sgShLzhmgW3I3a+PdTi7XYggTHIVJpzIoH+aa7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281304; c=relaxed/simple;
	bh=hOfKxzhdTmey8WYXN41vEXsEPkEdNzPJxYOkNzJ6hFY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C4Um9R3XN8/w3oBE1rUziWIoY15zHklYE1GSv1V69ulkpNMl9RBZ4qvwVsmvqMKUeoyVbfpXLrZFees3cUOS0m1Vp+qTb8M2biuA9nZJkpkolJsADp7f4PMlcewHDEy1FkJUm/e4PMkZvnPEiDm06OE7FU8mDCvlPKVG+dS1sTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hFfnlEQF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755281294;
	bh=hOfKxzhdTmey8WYXN41vEXsEPkEdNzPJxYOkNzJ6hFY=;
	h=Date:From:To:Subject:From;
	b=hFfnlEQFWhpzfRwAJHHTm7pCvXk9Mncs6YBlXe+d77UvSxmGMl55xaCkxsYTms+Hg
	 POMAf5cuRkH5QXV/IgSVLAEQtENuioXxk0QsOLPBoFj5nU71+o8pK1SHc8Bj56U/JA
	 yfBwgEZvzxH340DpTkpitNgAoEirpTfn74K4tZnI=
Date: Fri, 15 Aug 2025 20:08:14 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: stable@vger.kernel.org
Subject: [BACKPORT REQUEST] mfd: cros_ec: Separate charge-control probing
 from USB-PD
Message-ID: <27b5275e-ee5d-4059-9886-0dc3a868b905@t-8ch.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear stable team,

I'd like to have the following commit backported to v6.16 and v6.15:

e40fc1160d49 ("mfd: cros_ec: Separate charge-control probing from USB-PD")

It fixes probing issues for the cros-charge-control driver, for details
see the commit message.
As far as I can see, the commit also was marked for -stable backporting
from the beginning. Somehow this doesn't seem to have worked.

Thanks for your consideration,
Thomas

