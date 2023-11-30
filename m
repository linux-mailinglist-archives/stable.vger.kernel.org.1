Return-Path: <stable+bounces-3263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F87FF3D8
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2369B20D73
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80B537E5;
	Thu, 30 Nov 2023 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="rPLsZVZE"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2010DF
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:To:From:
	Date:cc:subject:date:message-id:reply-to;
	bh=L6c8YEPUjhs486jZ86UhMLQyfRljF+lfXlZh+sQm62k=; b=rPLsZVZEGl3HyCTNlF7z9NDOJQ
	27uX1UGheeMJjUeELADl4DFTaK/5pPEsnHD0t4AFoiDn38H7gIX/uGqzwTsIOMy0uSs3dQP2F+09t
	or6o3r6y+KacQCGNJAWx5vGDL+zzQEvHsie17jQnLLVY8W9gUlUD7fDKY7mioWtMia+k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42806 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r8jDm-0001KW-OS
	for stable@vger.kernel.org; Thu, 30 Nov 2023 10:44:59 -0500
Date: Thu, 30 Nov 2023 10:44:58 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org
Message-Id: <20231130104458.d1059ec296a655f8312663c3@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: auxdisplay: hd44780: move cursor home after clear display
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi,
the following patch:

35b464e32c8b auxdisplay: hd44780: move cursor home after clear display
command

Was introduced in kernel 6.6.

Without it, the LCD messages are not displayed in the correct
position.

I would like it to be applied to the stable kernel 6.1.

The patch applies cleanly and was tested on this kernel using a
custom board with a Variscite IMX8MN NANO SOM and a NewHaven LCD.

Thank you,
Hugo Villeneuve

