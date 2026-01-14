Return-Path: <stable+bounces-208338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31779D1D7A3
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 10:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101C2302DCAB
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B563803E9;
	Wed, 14 Jan 2026 09:17:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329A37F8B0;
	Wed, 14 Jan 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382237; cv=none; b=D3yF4B9v3cJv2THh67xhHTrOLQhgtrUT1F8Ipv2kn3qqqfP+o4yePEaAYOYbEZgIngau39muBkC1FebuCSkJjCCARLwsnPAvA1OyunvzKeM2YVdkiTHsUtgtV11oWP4NUh2xC6q4CKAhJufrm2/E5TesGBXzUNZoXx8p1T6cUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382237; c=relaxed/simple;
	bh=f6mizSXYfiX4UrL28TthCwr5Nr9HvVn4bJL9YsfTPm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKYsg5ZMxXAyhqv7oX/VEJkrVZV2Dtwqm2yoCkJhvhNCe/tkRBkvVCFBtG2QDtZ7LYW8BKuI2Qot9b4mPAfuaQ7FVV3jIZs06pZ7xQsMigslv733Li9D5XyZ6lkP65Ktl0uN4Nmc1tM4znoOe6B/sF7PfGS4PZZB9og40xrtbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.133] (unknown [185.238.219.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E14B02394ABD9;
	Wed, 14 Jan 2026 10:16:31 +0100 (CET)
Message-ID: <ff44a005-6ebf-45ed-9b84-804d44e2158c@molgen.mpg.de>
Date: Wed, 14 Jan 2026 10:16:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: fix retry for AQ
 command 0x06EE
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
 stable@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
 <20260113193817.582-3-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260113193817.582-3-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Dawid, dear Jakub,


Thank you for your patch.

Am 13.01.26 um 20:38 schrieb Dawid Osuchowski:
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> 
> Executing ethtool -m can fail reporting a netlink I/O error while firmware
> link management holds the i2c bus used to communicate with the module.
> 
> According to Intel(R) Ethernet Controller E810 Datasheet Rev 2.8 [1]
> Section 3.3.10.4 Read/Write SFF EEPROM (0x06EE)
> request should to be retried upon receiving EBUSY from firmware.
> 
> Commit e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
> implemented it only for part of ice_get_module_eeprom(), leaving all other
> calls to ice_aq_sff_eeprom() vulnerable to returning early on getting
> EBUSY without retrying.
> 
> Remove the retry loop from ice_get_module_eeprom() and add Admin Queue
> (AQ) command with opcode 0x06EE to the list of commands that should be
> retried on receiving EBUSY from firmware.
> 
> Cc: stable@vger.kernel.org
> Fixes: e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Link: https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html [1]
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c  |  1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 35 ++++++++------------
>   2 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index aab00c44e9b2..26eb8e05498b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1854,6 +1854,7 @@ static bool ice_should_retry_sq_send_cmd(u16 opcode)
>   	case ice_aqc_opc_lldp_stop:
>   	case ice_aqc_opc_lldp_start:
>   	case ice_aqc_opc_lldp_filter_ctrl:
> +	case ice_aqc_opc_sff_eeprom:
>   		return true;
>   	}
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 3565a5d96c6d..478876908db1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -4496,7 +4496,7 @@ ice_get_module_eeprom(struct net_device *netdev,
>   	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
>   	struct ice_hw *hw = &pf->hw;
>   	bool is_sfp = false;
> -	unsigned int i, j;
> +	unsigned int i;
>   	u16 offset = 0;
>   	u8 page = 0;
>   	int status;
> @@ -4538,26 +4538,19 @@ ice_get_module_eeprom(struct net_device *netdev,
>   		if (page == 0 || !(data[0x2] & 0x4)) {
>   			u32 copy_len;
>   
> -			/* If i2c bus is busy due to slow page change or
> -			 * link management access, call can fail. This is normal.
> -			 * So we retry this a few times.
> -			 */
> -			for (j = 0; j < 4; j++) {
> -				status = ice_aq_sff_eeprom(hw, 0, addr, offset, page,
> -							   !is_sfp, value,
> -							   SFF_READ_BLOCK_SIZE,
> -							   0, NULL);
> -				netdev_dbg(netdev, "SFF %02X %02X %02X %X = %02X%02X%02X%02X.%02X%02X%02X%02X (%X)\n",
> -					   addr, offset, page, is_sfp,
> -					   value[0], value[1], value[2], value[3],
> -					   value[4], value[5], value[6], value[7],
> -					   status);
> -				if (status) {
> -					usleep_range(1500, 2500);
> -					memset(value, 0, SFF_READ_BLOCK_SIZE);
> -					continue;
> -				}
> -				break;
> +			status = ice_aq_sff_eeprom(hw, 0, addr, offset, page,
> +						   !is_sfp, value,
> +						   SFF_READ_BLOCK_SIZE,
> +						   0, NULL);
> +			netdev_dbg(netdev, "SFF %02X %02X %02X %X = %02X%02X%02X%02X.%02X%02X%02X%02X (%pe)\n",
> +				   addr, offset, page, is_sfp,
> +				   value[0], value[1], value[2], value[3],
> +				   value[4], value[5], value[6], value[7],
> +				   ERR_PTR(status));
> +			if (status) {
> +				netdev_err(netdev, "%s: error reading module EEPROM: status %pe\n",
> +					   __func__, ERR_PTR(status));
> +				return status;
>   			}
>   
>   			/* Make sure we have enough room for the new block */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

