Return-Path: <stable+bounces-181778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609EBA4892
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 18:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F67B3DBE
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384323313E;
	Fri, 26 Sep 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="CLDt14uq"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (email.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECE8287E
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902485; cv=none; b=VTZPNYzNvVCGndOrpShPR6RBx0nsNW+mcnmVE5BUlWVl7DnqmDbFGCt2HHHY4UeiEmaMiudGgmdxRGMAyqms7VdFwmdi2GQPYEia3S9fJLP/uEJz7Gs16keljYD6ivI+O38BS8vKj79hRArk8jda8FFM3AT03YQjHbaTQz1hnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902485; c=relaxed/simple;
	bh=Ukz9UfME2K7FjHRtl632IX6w42BYHN4SZrIPnvn2Frc=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=t7OTnFujHaB8n0EScTJ0SKhJWqDELmHpS6dK/GcyAnuuUukTZunOAUY+ErrFwqQ+tn8+bEU2W+tBR7eT62S4UfI7dkdwnPXkR+nDFc000s3M3lO01ldv0SSErLEWG9a42JzM6e8qo+jUdmQgEkwgVrbnZ7i3rU+pnO7Xr2pKN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=pass smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=CLDt14uq; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4cYFWD4CYSzRhRP;
	Fri, 26 Sep 2025 17:54:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1758902040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eRcrcS13DEqF+x2XgpCm1iplTE02DSAvpCPeQkNNxR8=;
	b=CLDt14uq53hZneEXIUZSRP0ueGpG5Ii1s9mUZRTQ1+73c1BlPdAs3d0vWiW95cu1k3pVyS
	omFS17WZKzOFCbHnq4wtgTx7Eq5T0KoA+isTyePTzzLDl2JyItVDa8uyEy4L9aHiga5kwJ
	Tj3NFc2ebD3HH3J8vZemCJ4vz9AiGZPdNG8GE7JhhUq2AmVQlgyyLqQYtuoG1VGzFq2U5O
	cnYMfvuyfN75vPuVSNSYOryxE2aRDQfBjhC1DEVswQtKDo4p4evRzPc9j1C4ImBsjWZYSJ
	jbH7bCDKqWojvJWS6hPAh+tsktJrjknJ82tGK0Hl5vsyVpQIyFufvjfaX7sOUg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Sep 2025 17:54:00 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Niklas Neronin <niklas.neronin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: regression from 6.12.48 to 6.12.49: usb wlan adaptor stops working:
 bisected
Message-ID: <01b8c8de46251cfaad1329a46b7e3738@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello,o
after upgrading to 6.12.49 my wlan adapter stops working. It is 
detected:

kernel: mt76x2u 4-2:1.0: ASIC revision: 76120044
kernel: mt76x2u 4-2:1.0: ROM patch build: 20141115060606a
kernel: usb 3-4: reset high-speed USB device number 2 using xhci_hcd
kernel: mt76x2u 4-2:1.0: Firmware Version: 0.0.00
kernel: mt76x2u 4-2:1.0: Build: 1
kernel: mt76x2u 4-2:1.0: Build Time: 201507311614____

but does nor work. The following 2 messages probably are relevant:

kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
kernel: mt76x2u 4-2:1.0: MAC RX failed to stop

later I see a lot of

kernel: mt76x2u 4-2:1.0: error: mt76x02u_mcu_wait_resp failed with -110


I bisected it down to commit

9b28ef1e4cc07cdb35da257aa4358d0127168b68
usb: xhci: remove option to change a default ring's TRB cycle bit


9b28ef1e4cc07cdb35da257aa4358d0127168b68 is the first bad commit
commit 9b28ef1e4cc07cdb35da257aa4358d0127168b68
Author: Niklas Neronin <niklas.neronin@linux.intel.com>
Date:   Wed Sep 17 08:39:07 2025 -0400

     usb: xhci: remove option to change a default ring's TRB cycle bit

     [ Upstream commit e1b0fa863907a61e86acc19ce2d0633941907c8e ]

     The TRB cycle bit indicates TRB ownership by the Host Controller 
(HC) or
     Host Controller Driver (HCD). New rings are initialized with 
'cycle_state'
     equal to one, and all its TRBs' cycle bits are set to zero. When 
handling
     ring expansion, set the source ring cycle bits to the same value as 
the
     destination ring.

     Move the cycle bit setting from xhci_segment_alloc() to 
xhci_link_rings(),
     and remove the 'cycle_state' argument from 
xhci_initialize_ring_info().
     The xhci_segment_alloc() function uses kzalloc_node() to allocate 
segments,
     ensuring that all TRB cycle bits are initialized to zero.

     Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
     Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
     Link: 
https://lore.kernel.org/r/20241106101459.775897-12-mathias.nyman@linux.intel.com
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     Stable-dep-of: a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring 
after several reconnects")
     Signed-off-by: Sasha Levin <sashal@kernel.org>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>




Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

