Return-Path: <stable+bounces-142813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F73FAAF4C3
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9F81C073EE
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FC22538F;
	Thu,  8 May 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="Um7yZ+3/"
X-Original-To: stable@vger.kernel.org
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650F2248A6;
	Thu,  8 May 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689830; cv=none; b=pv7F02Xgnjx7or3QfSqaEmfD+U9cA6ktM2Qycjo1RDuH7OQmXD7Ar8mshu3Pzukdia0I2eLSJZVGOiZ5kxD9hq9Z6pzvk6NrUeFzCAeYQIuXRK6infCb21tGSOlN/Xrn93WvOUuzyxnuuBefqe6Ctmymajmcj10UFeImQqsYCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689830; c=relaxed/simple;
	bh=PDN/gK0e9nksO/e0fMKNuCkmsVxa4j1m/bDsuxAY8dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8x3HRnLSNoscuDsjfhEzN1uRO4wJUhvOMAD78JhT3MAygWnG2G8fbqOtqW1ipEgesJMmg0JzjTZbFZhJ7PM4qZEBAp8DYbvW7iihyVNUpEZe+7XK8ImKFxLJpZhAQxQH3sgNyVH+sl/bk6cOOzPtD3RcRd8xsyDJeZgeqLouqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=Um7yZ+3/; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Received: by m.b4.vu (Postfix, from userid 1000)
	id E15EE6698FAF; Thu,  8 May 2025 17:00:44 +0930 (ACST)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu E15EE6698FAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1746689444; bh=6UXt1BLwGoaNZgKxHK1YJO3spw1jLrC52dMEz3YS0QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Um7yZ+3/iqSsjao6eljDCKxaWAD+DncNagXdz3mFXGIxRezqt6Knlx0GrD3xHWfXP
	 qxq6un9Z/s2RkIqLMR11NyVmddaS1QKCYLZKdz/Tr5PFIGf7rXuSFH/xhauV/BhCdo
	 zwuZ8/uAd5P/K9NSfxGKkOUjh5cplYywUU7UOmBX29KU/SH8tzFBWhr98vSP2P9zw9
	 5gdKanB0U5oNavB7LnwEbfp9X7DWHmW1xA3TdThKMO2bBijagCZ54pvxws8neVWaUz
	 IKu2WmvL2PONMkvIGrMTQ8ZOGKST2wzya6qhZc8Y4R0a+S252X3zHZIO1y1x81EiaB
	 bi2te+GomZUIA==
Date: Thu, 8 May 2025 17:00:44 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>, pmenzel@molgen.mpg.de,
	tiwai@suse.de, geraldogabriel@gmail.com,
	regressions@lists.linux.dev, gregkh@linuxfoundation.org
Subject: [STABLE 6.12/6.14] Bluetooth MediaTek controller reset fixes
Message-ID: <aBxdpIabalg073AU@m.b4.vu>
References: <Z+W6dmZFfC7SBhza@m.b4.vu>
 <Z+XN2a3141NpZKcb@m.b4.vu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+XN2a3141NpZKcb@m.b4.vu>

Hi stable@vger.kernel.org,

Could you please apply:

1. Commit a7208610761ae ("Bluetooth: btmtk: Remove resetting mt7921
before downloading the fw") to v6.12.x (it's already in
v6.14).

2. Commit 33634e2ab7c6 ("Bluetooth: btmtk: Remove the resetting step
before downloading the fw") to v6.12.x and v6.14.x.

These fixes address an issue with some audio interfaces failing to
initialise during boot on kernels 6.11+. As noted in my original
analysis below, the MediaTek Bluetooth controller reset increases the
device setup time from ~200ms to ~20s and can interfere with other USB
devices on the bus.

Thanks,
Geoffrey.

On Fri, Mar 28, 2025 at 08:44:49AM +1030, Geoffrey D. Bennett wrote:
> Hi all,
> 
> Sorry, I see that an identical patch has already been applied to
> bluetooth-next
> https://lore.kernel.org/linux-bluetooth/20250315022730.11071-1-hao.qin@mediatek.com/
> 
> While I'm glad the issue is being addressed, my original patch
> https://lore.kernel.org/linux-bluetooth/Z8ybV04CVUfVAykH@m.b4.vu/
> contained useful context and tags that didn't make it into the final
> commit.
> 
> For getting this fix into current kernel releases 6.12/6.13/6.14, I
> think the patch needs the "Cc: stable@vger.kernel.org" tag that was in
> my original submission but missing from Hao's. Since this is causing
> significant issues for users on kernels 6.11+ (audio interfaces
> failing to work), it's important this gets backported.
> 
> Hao, is this something you can do? I think the instructions at
> https://www.kernel.org/doc/html/v6.14/process/stable-kernel-rules.html#option-3
> need to be followed, but I've not done this before.
> 
> Thanks,
> Geoffrey.
> 
> On Fri, Mar 28, 2025 at 07:22:06AM +1030, Geoffrey D. Bennett wrote:
> > This reverts commit ccfc8948d7e4d93cab341a99774b24586717d89a.
> > 
> > The MediaTek Bluetooth controller reset that was added increases the
> > Bluetooth device setup time from ~200ms to ~20s and interferes with
> > other devices on the bus.
> > 
> > Three users (with Focusrite Scarlett 2nd Gen 6i6 and 3rd Gen Solo and
> > 4i4 audio interfaces) reported that since 6.11 (which added this
> > commit) their audio interface fails to initialise if connected during
> > boot. Two of the users confirmed they have an MT7922.
> > 
> > Errors like this are observed in dmesg for the audio interface:
> > 
> >   usb 3-4: parse_audio_format_rates_v2v3(): unable to find clock source (clock -110)
> >   usb 3-4: uac_clock_source_is_valid(): cannot get clock validity for id 41
> >   usb 3-4: clock source 41 is not valid, cannot use
> > 
> > The problem only occurs when both devices and kernel modules are
> > present and loaded during system boot, so it can be worked around by
> > connecting the audio interface after booting.
> > 
> > Fixes: ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller before downloading the fw")
> > Closes: https://github.com/geoffreybennett/linux-fcp/issues/24
> > Bisected-by: Benedikt Ziemons <ben@rs485.network>
> > Tested-by: Benedikt Ziemons <ben@rs485.network>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> > 
> > - Updated commit message with additional information.
> > - No change to this patch's diff.
> > - Dropped alternate patch that only reverted for 0x7922.
> > - Chris, Sean, Hao agreed to reverting the change:
> >   https://lore.kernel.org/linux-bluetooth/2025031352-octopus-quadrant-f7ca@gregkh/T/#m0b31a9a8e87b9499e1ec3370c08f03e43bfb54bf
> > 
> >  drivers/bluetooth/btmtk.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index 68846c5bd4f7..4390fd571dbd 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -1330,13 +1330,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> >  		break;
> >  	case 0x7922:
> >  	case 0x7925:
> > -		/* Reset the device to ensure it's in the initial state before
> > -		 * downloading the firmware to ensure.
> > -		 */
> > -
> > -		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
> > -			btmtk_usb_subsys_reset(hdev, dev_id);
> > -		fallthrough;
> >  	case 0x7961:
> >  		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
> >  				      fw_version, fw_flavor);
> > @@ -1345,12 +1338,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> >  						btmtk_usb_hci_wmt_sync);
> >  		if (err < 0) {
> >  			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
> > -			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
> >  			return err;
> >  		}
> > 
> > -		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
> > -
> >  		/* It's Device EndPoint Reset Option Register */
> >  		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
> >  					      MTK_EP_RST_IN_OUT_OPT);
> > --
> > 2.45.0
> > 
> > 
> > 

