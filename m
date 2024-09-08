Return-Path: <stable+bounces-73933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D99709BA
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046B0281759
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA9178CD9;
	Sun,  8 Sep 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=n621.de header.i=@n621.de header.b="wxVX4TA2"
X-Original-To: stable@vger.kernel.org
Received: from nyx.n621.de (v4gw.hekate.n621.de [136.243.2.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B1176FDB
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.2.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827623; cv=none; b=Q55BaDbpAEGP7kcXIqjH7aACPQGaA3XY+cnZAfgjsTiKWJFB2ZstCzT/oVAUtIy98tolI66l2mKkPPjovQQkxWoP7tRuL1dtagb6yBM+9qu/rf/PWt0qGntthhoJ4P0NTVFKjxVqgiMNYrR2ero4Wk4hSMTs+yzOXqIM8vLimbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827623; c=relaxed/simple;
	bh=eYG8JwMlzmjNVLdQIN2lQylji91gWXM403XMaNnFl6k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=loKwwGeMSbnH/nGbtOls/+aOIccN1zRmLSOb0gjVr0N0YZuUpz1JBifWjniTua7UFwVecg/JCFaJeiYLPcrwamtzWjRAPAW7QbTm/TIN0ihj91TF1BHlGKsYPEevoJRCDzmTs2EqChOWBcM9FBq4wo4FthuS8IWKuF2tc2u9tyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=n621.de; spf=pass smtp.mailfrom=n621.de; dkim=pass (1024-bit key) header.d=n621.de header.i=@n621.de header.b=wxVX4TA2; arc=none smtp.client-ip=136.243.2.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=n621.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n621.de
Received: by nyx.n621.de (Postfix, from userid 1000)
	id 8E7A4E00375; Sun,  8 Sep 2024 22:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n621.de; s=dkim;
	t=1725827182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=eYG8JwMlzmjNVLdQIN2lQylji91gWXM403XMaNnFl6k=;
	b=wxVX4TA22LgCy5/u3f84hA07pE1piP5mKCRkfulnMTJxXO7cK6HTFdt03cZVX+8DrThZ94
	B+kstdfrJKJqGkBPb7wFTU0DohnLK7GUNWQ2N2MwfJbRKxKnqSCZGyWclWqpgK2qIoPN/Q
	afeBbcIVQIEAgGr1we+0NmToc0oDAEc=
Date: Sun, 8 Sep 2024 22:26:22 +0200
From: Florian Larysch <fl@n621.de>
To: stable@vger.kernel.org
Subject: Please pick up "intel: legacy: Partial revert of field get
 conversion" for 6.6
Message-ID: <20240908202622.u5m6djorugknxfmi@n621.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The patch "intel: legacy: Partial revert of field get conversion"
(commit ba54b1a276a6b69d80649942fe5334d19851443e in mainline) fixes a
broken refactoring that prevents Wake-on-LAN from working on some e1000e
devices.

v6.10 already includes that fix and v6.1 and earlier did not yet contain
the offending refactoring, so it should only be necessary to apply this
to 6.6.

Thanks!

