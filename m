Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDC7B98BF
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjJDXj6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjJDXj5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 19:39:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FECE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 16:39:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64C8C433C8;
        Wed,  4 Oct 2023 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696462793;
        bh=1b+bxsn19Q8T7L/gabU7LPcV9N7rRqKMVisEvYO41K0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TKXJqo7SPjHTnpAmGIHd4S0rZC95Dup7Vr+g0Ca71Vr/rJTG6nueO15+bHQL3VuZS
         MZUl/9VeGGJZlPsgb9/ejFLYdBIm2nPqi3xljwiAsSzXRyChs1Hzdymepew/s3lDlB
         XfCOow34rX7KOh5MLNUjQCAjReilIJlS5aHwDptFjQW1F1YKg8TJ45mvpuNpSI3h5u
         Tvry22KTsUd6D5BY3/s52oxzg0ZQbT2WAUYVVjlWgc9xOtufPwpmODOFF0kIh9cKBq
         GbH3U1VOsDV2be3JiG3GP+H5jMPcLZ2OXLJKaOwkWHH6aZdtIMRSxz2IyTeb2yvqyP
         Wjfs79EhtVaUg==
Message-ID: <e3e9eb6f-cfc1-9685-1205-f755cb14c3f3@kernel.org>
Date:   Thu, 5 Oct 2023 08:39:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: FAILED: patch "[PATCH] ata: libata-scsi: Fix delayed
 scsi_rescan_device() execution" failed to apply to 6.5-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, geert+renesas@glider.be, hare@suse.de,
        martin.petersen@oracle.com, niklas.cassel@wdc.com
Cc:     stable@vger.kernel.org
References: <2023100443-freewill-shanty-0f05@gregkh>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2023100443-freewill-shanty-0f05@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/4/23 23:32, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.5-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8b4d9469d0b0e553208ee6f62f2807111fde18b9
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100443-freewill-shanty-0f05@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> 
> Possible dependencies:

commit ff48b37802e5c134e2dfc4d091f10b2eb5065a72

    scsi: Do not attempt to rescan suspended devices

is needed to backport this one.

> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 8b4d9469d0b0e553208ee6f62f2807111fde18b9 Mon Sep 17 00:00:00 2001
> From: Damien Le Moal <dlemoal@kernel.org>
> Date: Tue, 5 Sep 2023 09:06:23 +0900
> Subject: [PATCH] ata: libata-scsi: Fix delayed scsi_rescan_device() execution
> 
> Commit 6aa0365a3c85 ("ata: libata-scsi: Avoid deadlock on rescan after
> device resume") modified ata_scsi_dev_rescan() to check the scsi device
> "is_suspended" power field to ensure that the scsi device associated
> with an ATA device is fully resumed when scsi_rescan_device() is
> executed. However, this fix is problematic as:
> 1) It relies on a PM internal field that should not be used without PM
>    device locking protection.
> 2) The check for is_suspended and the call to scsi_rescan_device() are
>    not atomic and a suspend PM event may be triggered between them,
>    casuing scsi_rescan_device() to be called on a suspended device and
>    in that function blocking while holding the scsi device lock. This
>    would deadlock a following resume operation.
> These problems can trigger PM deadlocks on resume, especially with
> resume operations triggered quickly after or during suspend operations.
> E.g., a simple bash script like:
> 
> for (( i=0; i<10; i++ )); do
> 	echo "+2 > /sys/class/rtc/rtc0/wakealarm
> 	echo mem > /sys/power/state
> done
> 
> that triggers a resume 2 seconds after starting suspending a system can
> quickly lead to a PM deadlock preventing the system from correctly
> resuming.
> 
> Fix this by replacing the check on is_suspended with a check on the
> return value given by scsi_rescan_device() as that function will fail if
> called against a suspended device. Also make sure rescan tasks already
> scheduled are first cancelled before suspending an ata port.
> 
> Fixes: 6aa0365a3c85 ("ata: libata-scsi: Avoid deadlock on rescan after device resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a0bc01606b30..092372334e92 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5168,11 +5168,27 @@ static const unsigned int ata_port_suspend_ehi = ATA_EHI_QUIET
>  
>  static void ata_port_suspend(struct ata_port *ap, pm_message_t mesg)
>  {
> +	/*
> +	 * We are about to suspend the port, so we do not care about
> +	 * scsi_rescan_device() calls scheduled by previous resume operations.
> +	 * The next resume will schedule the rescan again. So cancel any rescan
> +	 * that is not done yet.
> +	 */
> +	cancel_delayed_work_sync(&ap->scsi_rescan_task);
> +
>  	ata_port_request_pm(ap, mesg, 0, ata_port_suspend_ehi, false);
>  }
>  
>  static void ata_port_suspend_async(struct ata_port *ap, pm_message_t mesg)
>  {
> +	/*
> +	 * We are about to suspend the port, so we do not care about
> +	 * scsi_rescan_device() calls scheduled by previous resume operations.
> +	 * The next resume will schedule the rescan again. So cancel any rescan
> +	 * that is not done yet.
> +	 */
> +	cancel_delayed_work_sync(&ap->scsi_rescan_task);
> +
>  	ata_port_request_pm(ap, mesg, 0, ata_port_suspend_ehi, true);
>  }
>  
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a0e58d22d222..6850cac803c1 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4756,7 +4756,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>  	struct ata_link *link;
>  	struct ata_device *dev;
>  	unsigned long flags;
> -	bool delay_rescan = false;
> +	int ret = 0;
>  
>  	mutex_lock(&ap->scsi_scan_mutex);
>  	spin_lock_irqsave(ap->lock, flags);
> @@ -4765,37 +4765,34 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>  		ata_for_each_dev(dev, link, ENABLED) {
>  			struct scsi_device *sdev = dev->sdev;
>  
> +			/*
> +			 * If the port was suspended before this was scheduled,
> +			 * bail out.
> +			 */
> +			if (ap->pflags & ATA_PFLAG_SUSPENDED)
> +				goto unlock;
> +
>  			if (!sdev)
>  				continue;
>  			if (scsi_device_get(sdev))
>  				continue;
>  
> -			/*
> -			 * If the rescan work was scheduled because of a resume
> -			 * event, the port is already fully resumed, but the
> -			 * SCSI device may not yet be fully resumed. In such
> -			 * case, executing scsi_rescan_device() may cause a
> -			 * deadlock with the PM code on device_lock(). Prevent
> -			 * this by giving up and retrying rescan after a short
> -			 * delay.
> -			 */
> -			delay_rescan = sdev->sdev_gendev.power.is_suspended;
> -			if (delay_rescan) {
> -				scsi_device_put(sdev);
> -				break;
> -			}
> -
>  			spin_unlock_irqrestore(ap->lock, flags);
> -			scsi_rescan_device(sdev);
> +			ret = scsi_rescan_device(sdev);
>  			scsi_device_put(sdev);
>  			spin_lock_irqsave(ap->lock, flags);
> +
> +			if (ret)
> +				goto unlock;
>  		}
>  	}
>  
> +unlock:
>  	spin_unlock_irqrestore(ap->lock, flags);
>  	mutex_unlock(&ap->scsi_scan_mutex);
>  
> -	if (delay_rescan)
> +	/* Reschedule with a delay if scsi_rescan_device() returned an error */
> +	if (ret)
>  		schedule_delayed_work(&ap->scsi_rescan_task,
>  				      msecs_to_jiffies(5));
>  }
> 

-- 
Damien Le Moal
Western Digital Research

