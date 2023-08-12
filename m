Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176677A2FC
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 22:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHLU7J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Sat, 12 Aug 2023 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLU7J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 16:59:09 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Aug 2023 13:59:12 PDT
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518F41709
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 13:59:12 -0700 (PDT)
Received: from [192.168.2.4] (51b68fab.dsl.pool.telekom.hu [::ffff:81.182.143.171])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072C5F.0000000064D7F03A.0002FD28; Sat, 12 Aug 2023 22:48:58 +0200
Message-ID: <3d4143b70eaeb45e6feabde0c9d90c1a07312163.camel@irl.hu>
Subject: Re: [PATCH] platform/x86: lenovo-ymc: Only bind on machines with a
 convertible DMI chassis-type
From:   =?UTF-8?Q?Gerg=C5=91_K=C3=B6teles?= <soyer@irl.hu>
To:     Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Andrew Kallmeyer <kallmeyeras@gmail.com>,
        =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        stable@vger.kernel.org
Date:   Sat, 12 Aug 2023 22:48:57 +0200
In-Reply-To: <20230812144818.383230-1-hdegoede@redhat.com>
References: <20230812144818.383230-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Sat, 2023-08-12 at 16:48 +0200, Hans de Goede wrote:
> The lenovo-ymc driver is causing the keyboard + touchpad to stop working
> on some regular laptop models such as the Lenovo ThinkBook 13s G2 ITL 20V9.
> 
> The problem is that there are YMC WMI GUID methods in the ACPI tables
> of these laptops, despite them not being Yogas and lenovo-ymc loading
> causes libinput to see a SW_TABLET_MODE switch with state 1.
> 
> This in turn causes libinput to ignore events from the builtin keyboard
> and touchpad, since it filters those out for a Yoga in tablet mode.
> 
> Similar issues with false-positive SW_TABLET_MODE=1 reporting have
> been seen with the intel-hid driver.
> 
> Copy the intel-hid driver approach to fix this and only bind to the WMI
> device on machines where the DMI chassis-type indicates the machine
> is a convertible.
> 
> Add a 'force' module parameter to allow overriding the chassis-type check
> so that users can easily test if the YMC interface works on models which
> report an unexpected chassis-type.
> 
> Fixes: e82882cdd241 ("platform/x86: Add driver for Yoga Tablet Mode switch")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229373
> Cc: Gergo Koteles <soyer@irl.hu>
> Cc: Andrew Kallmeyer <kallmeyeras@gmail.com>
> Cc: André Apitzsch <git@apitzsch.eu>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for fixing this!
It works on Yoga 7 14ARB7.

Tested-by: Gergő Köteles <soyer@irl.hu>

Regards,
Gergő

> ---
> Note: The chassis-type can be checked by doing:
> cat /sys/class/dmi/id/chassis_type
> if this reports 31 or 32 then this patch should not have any impact
> on your machine.
> ---
>  drivers/platform/x86/lenovo-ymc.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
> index 41676188b373..f360370d5002 100644
> --- a/drivers/platform/x86/lenovo-ymc.c
> +++ b/drivers/platform/x86/lenovo-ymc.c
> @@ -24,6 +24,10 @@ static bool ec_trigger __read_mostly;
>  module_param(ec_trigger, bool, 0444);
>  MODULE_PARM_DESC(ec_trigger, "Enable EC triggering work-around to force emitting tablet mode events");
>  
> +static bool force;
> +module_param(force, bool, 0444);
> +MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
> +
>  static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
>  	{
>  		/* Lenovo Yoga 7 14ARB7 */
> @@ -35,6 +39,20 @@ static const struct dmi_system_id ec_trigger_quirk_dmi_table[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "32" /* Detachable */),
> +		},
> +	},
> +	{ }
> +};
> +
>  struct lenovo_ymc_private {
>  	struct input_dev *input_dev;
>  	struct acpi_device *ec_acpi_dev;
> @@ -111,6 +129,13 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
>  	struct input_dev *input_dev;
>  	int err;
>  
> +	if (!dmi_check_system(allowed_chasis_types_dmi_table)) {
> +		if (force)
> +			dev_info(&wdev->dev, "Force loading Lenovo YMC support\n");
> +		else
> +			return -ENODEV;
> +	}
> +
>  	ec_trigger |= dmi_check_system(ec_trigger_quirk_dmi_table);
>  
>  	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);

