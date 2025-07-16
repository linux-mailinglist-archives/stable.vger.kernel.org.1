Return-Path: <stable+bounces-163200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63755B07F50
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 23:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA6D1899A18
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0B28F533;
	Wed, 16 Jul 2025 21:09:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B64A11
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700157; cv=none; b=WrvnlI3HQFT0g62pLMoBEFH+y9TG+ntEc6Iqpyc6fUPDefI33hHdJxRTnz+xlHYYAPBmGCOjOtRsxDjnuhhW98h5z66fnc4/t2g48rfKik2CRwnV7+FVcPr9KmA1WdHoU2zMsipG0OBeFjFcvB/M8yTtiHmA8UehrD2TV6OUqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700157; c=relaxed/simple;
	bh=VIyN70c29og3SX4uTqf4O8NSLHK2aAENu9pNUfC+Dcs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uq1yDBNBlxGqTbDkT5VEqtjBvn5t/Pr3OmH+pRMlZghn6yCpjPpA5T8AVxGynbEdTq9Ozv40BjkA8z8zQPhi+tADh9o1JMQ+pHumGr2tDWJH86uJaGFesgSbSAb2lcwLtY8VdcNHl0b4tzAwima4DnDqsHYFWLqaM75LrMOwQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de ADE2244664A2
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from WorkKnecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id ADE2244664A2
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 21:09:02 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
Date: Wed, 16 Jul 2025 23:08:58 +0200
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
To: stable@vger.kernel.org
Subject: Backport a5a441ae283d ("ice/ptp: fix crosstimestamp reporting")
Message-ID: <g2bzkfszeaajy4ehjodyg646fvgjih3gesgrq4duhoqcnkdbef@dmquxweqdzwq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Wed, 16 Jul 2025 21:09:02 +0000 (UTC)

Hi Greg,

please consider backporting

    a5a441ae283d ("ice/ptp: fix crosstimestamp reporting")

into linux-6.12.y

It fixes a regression from the series around
d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
which affected multiple drivers and occasionally
caused phc2sys to fail on ioctl(fd, PTP_SYS_OFFSET_PRECISE, ...).

This was the initial fix for ice but apparently tagging it
for stable was forgotten during submission.

A similar fix for e1000e can be found here:

Link: https://lore.kernel.org/lkml/20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de/

The hunk was moved around slightly in the upstream commit 
92456e795ac6 ("ice: Add unified ice_capture_crosststamp").
Let me know if you therefore want a separate patch,
I just didn't want to to steal the credits here.

Thanks a lot!

Markus

-- 

