Return-Path: <stable+bounces-128336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91774A7C0F1
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B89189F345
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A471F540F;
	Fri,  4 Apr 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpGEbGVA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sFAIJ8oY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E31E5B74
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781819; cv=none; b=ZSZSjnMXEG2nYpISJnLYchorKiaLS5Uoj4jc+DG6VdytiUAmO6ObwIe4DaOFt5o2ADFibSI81/PI4ci/tQkQm5pxD9wEtp9NhErGZsD+PeuOQq9HPV+pXfc4lXdyfitZC1i7iIRWUQCr+ID+u5/aaq5NT85epOqJ475UEoVqvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781819; c=relaxed/simple;
	bh=35PV+5ddnRVz11ZvPWH4+UaunTSCZMcU0E9PGaTK9+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZArx3WDBVRntPYBUrjwhKEDbz0f9Pr4WOQQJyiLKwTD1gnNRe4ebRz7SCVK/OnF1UyUxbSegwXmhKOIexaog18UHiFh1vF8FFn1Hsorl+2EWuAdVIApuVsS3Hi6H0c9+Dlfaa+SyKFhIZybt9jK9XTH1Q/7rJPSswTYLOZQjKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpGEbGVA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sFAIJ8oY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743781814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=HkRNIj2ue8FoQE9JZeX2lVvEt6DbURmQXqgUo2ZfHlQ=;
	b=hpGEbGVAWUJo2Sle9bF1a9zj6x4tirDKkLTa1alErP+iLMVjzOMMYKmeB9C/nrPikfu90v
	+Xn6hyaxDP2okgHaO6BJlG9KcooTqEIlQsy6xH6f2SeVqqa4gW6m8mI4louz0XO5XXxPiP
	aYknffqA/TeJpnBCw9xiZqs+Q6bFpq22HoDpMm9WsIHputiY9b7Xyv0Nfw2PZlQTyDoVaS
	3myDgmYcEa1Ajvipxw24TSuTrJQwTt+wdDd++ZKlfBJIfezh7YF5ILL59P1tEoAlMSrf77
	g/jhLgT6qZRCcuvH2rlTcdWO9v4zy8gniLxa28sLWarZaZZQDfSVnmS+r+MPMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743781814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=HkRNIj2ue8FoQE9JZeX2lVvEt6DbURmQXqgUo2ZfHlQ=;
	b=sFAIJ8oYC7QG/X+afj7ATHcmverTBYSJtD0Rjgqzrhq/NvnwJno5dvVLQFjHInBAgj9mvF
	q6PJBvcDOYk+hJBA==
To: stable@vger.kernel.org
Subject: Don't backport 757b000f7b93 ("timekeeping: Fix possible
 inconsistencies in _COARSE clockids")
Date: Fri, 04 Apr 2025 17:50:13 +0200
Message-ID: <87ecy8udsa.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi!

It turned out that this commit causes a regression for adjtimex() users,
so it will be reverted in mainline.

There is a different fix available which does not have that problem,
which will be marked with a Fixes tag and will be suitable for
backporting.

Thanks,

        tglx



