Return-Path: <stable+bounces-215641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOYOEEkGi2kdPQAAu9opvQ
	(envelope-from <stable+bounces-215641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:19:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC30119902
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1502D300E1B1
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15347355037;
	Tue, 10 Feb 2026 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="MEQQ1I4l"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71D352F8B
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718781; cv=pass; b=Xu6H+4/EI+RjJl4p0QClboZgdbw3VlyJcA7Nu2QR+lLnSg7uGiUtT5lKJvuziysE3EFjU+BNtADeT7ql/8SY56uL464KeTUv+liwWXsxuESp0f6wVClILsea0jeOg9zku1EMRyPA7W+ObDJc8kSpxcSZMshWCNEK6RMI9bNnkLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718781; c=relaxed/simple;
	bh=dSFTEfgXKbykpk9p92H0dQTA0zHwTAdF8HS1JKm5Wqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRhv1SldBShLhkm4MAVewks8RahhlGYItDx3k58ikMGrAVnra27NcGaPNu0cUyYCaFLXPdA3QP6AtPCNAhHFexL79KkrCJsqibW69LXtT1EOgZyr8SWOsnTvQyd/4d1tDstTTemEIvoJFSDD91ODt3ZtvgJqhHwfzqKr4pliSHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=MEQQ1I4l; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124afd03fd1so5702113c88.0
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 02:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770718780; cv=none;
        d=google.com; s=arc-20240605;
        b=XUOhly37ViCankZ8GKXJsiuQymd5/ITRyTOkLtsB8hRgfgg/YW2WsqO0fq7v45HoCN
         9BstyGk8lAYBuSC+mo/00gH99qoATdZ9XLANHwxCRtiSkdglXcCy0iqseHQTdAtitpaF
         bp5SnzRYQIOv74E4PqkiC3urQszcWE4pcbGyHZyjmua0XHSklQU728nW+LSj63JF4uoF
         MdeBQn/MvrimSaCc/dMJfmyUMo6/JyEDEZti36oZK9Hjd89qImI2N4ROtnuyX8Be5iq2
         VnsIXM2gI+JVJu6GDSfQ1wJTpC8ApjiWA5xG2TpzQaqsRfCqTm/cjD7YjyweMFOZzG1c
         eQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v1As3rR/RqPznaN0GwCfzUHJgmd9J2i2tp9S3bSufFU=;
        fh=YJl8sfY3EweGafbivy5vvqdbudxQkBEIuBYYyJ5Dnss=;
        b=UZVfP7cHuM7OCAnAZCTEs0d37ObOns3mXfayLGzl5oDbGCNDRklxWd98R5n7equ+SJ
         IzpqDwQkqgoGccUCIjlQp2qsF6Rx7jtcGJJIm0VgdmUKFLVAPYZ2RbpP9nfrq5AEsdGF
         pIZPr35PEA4biV4TypxbN/vCnGfxB1mr3c0WvBNvyKaRQbZNyj9zsyWsoajg/fwQBDnk
         VTlQCcI2oxeaCMnUObcrR9v9B7gENoG8stQu1/paQCPV+h9w7AHzhHMu6Ius8BlmcFPP
         AdvMDroB9TNBCqFOgB8NbCZpFJNmgt8gh2qpOGZpu+QCKfv+mXdMDI+FR2SNhyEkPC6N
         K7/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770718780; x=1771323580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1As3rR/RqPznaN0GwCfzUHJgmd9J2i2tp9S3bSufFU=;
        b=MEQQ1I4lWE9MgvDLtvWgySKQd/1kk8Bg9bOggYrx8DPzWTulCiMmz9sL84HuXcEnUv
         BLBV8/525un7MS8owKcHyhCowQt3cxeIbZswKRtkK4WvG9o5NMw8BHKrWOWCYk+ABUiy
         Rxfgd7/b1944uxLb785h20Tpu63XIsb4Y0ZjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718780; x=1771323580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1As3rR/RqPznaN0GwCfzUHJgmd9J2i2tp9S3bSufFU=;
        b=woCRuMUMlGwjoMapIQ0oMwwsM8BT+Mi3DnLLEpp8ULkhzUlEKd4fWoC62es+ZlQUln
         Xx0SoPFgvykb06vaR7KFUqB9vGkMnJUqjBQYsJtW9liexRwtaXKQApEeW3IoAzeRfln2
         NmyuGleVsxNVLt3iRUE8F2kt9ccX7Efy9L6NVZrni95aINDeWUo7gmnatugVY6Kp0jSj
         3fZQmsNeHnKotMgBSM02wMFSJ2XgCldPDU/bXRuCPikl46NHmjNibHAVT7XeX0+2A4JT
         U3gVG7l0u9djzdBVWAG4DL2qNn4B1o5Mu7Ldp9ErqVa+JtTUzp1+DDco3c9R1RtkP/77
         vFzA==
X-Gm-Message-State: AOJu0YzF7AgnqgQwNMyX4bM0eob0ivz5r0Dv3/RKx4DF44KZnWz/h+sX
	jIxsg27EPxR4CZkZ0n3TjQXo4V/uwZvdTkxNzqK34UUwG6AiCqpa+xDKyxe1rOTC7C8qEF6maWc
	bpir9daQQpdF0BIANhBpMm3HFD/EvWQydyni2uiRKYU3dxjNbjqEb9g==
X-Gm-Gg: AZuq6aK/kNHnw6v8s3gk7aEKt93ZvOuImywpL/hIXN1UAX48rGcFKRJewUogQJlEHId
	vUXCRoRJ2Q3AD+8lvdcQmSGzhnklGNQ5k8hXCJeFdWk8zIhwMr9nIZ9KcBjzE2uJnXmfn5/WqP+
	V3K88yHqqSW1y8+U4Yui0CpwA/SIu9QtsqYViprmI/9fHZH4EAfyJqhSVVnJa9WUQwoQP0zM+K/
	VqQJSk9G0eexm/cT3TZ3FH1TVAyOLT8MQHfcgOmNwptW31KCr+Hj5mNH4QG8mhuIKq37nEBm8Wj
	9lpco5jsayNs/7F55U8=
X-Received: by 2002:a05:7022:62a7:b0:11b:1c6d:98bd with SMTP id
 a92af1059eb24-12703f544a0mr5345549c88.9.1770718779531; Tue, 10 Feb 2026
 02:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142320.474120190@linuxfoundation.org> <20260209142325.330634333@linuxfoundation.org>
In-Reply-To: <20260209142325.330634333@linuxfoundation.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Tue, 10 Feb 2026 11:19:12 +0100
X-Gm-Features: AZwV_Qj7lRHJCwijfuEMUmqtqEp8DvF0UoJEcCYAAmPadURwkWOzymYFJDg8h-Q
Message-ID: <CAK8fFZ5n-og8dxFrh4J7pWW9h+iTp+AbdGUF1cd_7jDZpKEj8w@mail.gmail.com>
Subject: Re: [PATCH 6.18 134/175] hwmon: (acpi_power_meter) Fix deadlocks
 related to acpi_power_meter_notify()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215641-lists,stable=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gooddata.com:+]
X-Rspamd-Queue-Id: 5FC30119902
X-Rspamd-Action: no action

>
> 6.18-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> [ Upstream commit 615901b57b7ef8eb655f71358f7e956e42bcd16b ]
>
> The acpi_power_meter driver's .notify() callback function,
> acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
> that is also acquired by callbacks in sysfs attributes of the device
> being unregistered which is prone to deadlocks between sysfs access and
> device removal.
>
> Address this by moving the hwmon device removal in
> acpi_power_meter_notify() outside the lock in question, but notice
> that doing it alone is not sufficient because two concurrent
> METER_NOTIFY_CONFIG notifications may be attempting to remove the
> same device at the same time.  To prevent that from happening, add a
> new lock serializing the execution of the switch () statement in
> acpi_power_meter_notify().  For simplicity, it is a static mutex
> which should not be a problem from the performance perspective.
>
> The new lock also allows the hwmon_device_register_with_info()
> in acpi_power_meter_notify() to be called outside the inner lock
> because it prevents the other notifications handled by that function
> from manipulating the "resource" object while the hwmon device based
> on it is being registered.  The sending of ACPI netlink messages from
> acpi_power_meter_notify() is serialized by the new lock too which
> generally helps to ensure that the order of handling firmware
> notifications is the same as the order of sending netlink messages
> related to them.
>
> In addition, notice that hwmon_device_register_with_info() may fail
> in which case resource->hwmon_dev will become an error pointer,
> so add checks to avoid attempting to unregister the hwmon device
> pointer to by it in that case to acpi_power_meter_notify() and
> acpi_power_meter_remove().
>
> Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register")
> Closes: https://lore.kernel.org/linux-hwmon/CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com/
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/hwmon/acpi_power_meter.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 29ccdc2fb7ff8..de408df0c4d78 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -47,6 +47,8 @@
>  static int cap_in_hardware;
>  static bool force_cap_on;
>
> +static DEFINE_MUTEX(acpi_notify_lock);
> +
>  static int can_cap_in_hardware(void)
>  {
>         return force_cap_on || cap_in_hardware;
> @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>
>         resource = acpi_driver_data(device);
>
> +       guard(mutex)(&acpi_notify_lock);
> +
>         switch (event) {
>         case METER_NOTIFY_CONFIG:
> +               if (!IS_ERR(resource->hwmon_dev))
> +                       hwmon_device_unregister(resource->hwmon_dev);
> +
>                 mutex_lock(&resource->lock);
> +
>                 free_capabilities(resource);
>                 remove_domain_devices(resource);
> -               hwmon_device_unregister(resource->hwmon_dev);
>                 res = read_capabilities(resource);
>                 if (res)
>                         dev_err_once(&device->dev, "read capabilities failed.\n");
>                 res = read_domain_devices(resource);
>                 if (res && res != -ENODEV)
>                         dev_err_once(&device->dev, "read domain devices failed.\n");
> +
> +               mutex_unlock(&resource->lock);
> +
>                 resource->hwmon_dev =
>                         hwmon_device_register_with_info(&device->dev,
>                                                         ACPI_POWER_METER_NAME,
> @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>                                                         power_extra_groups);
>                 if (IS_ERR(resource->hwmon_dev))
>                         dev_err_once(&device->dev, "register hwmon device failed.\n");
> -               mutex_unlock(&resource->lock);
> +
>                 break;
>         case METER_NOTIFY_TRIP:
>                 sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(struct acpi_device *device)
>                 return;
>
>         resource = acpi_driver_data(device);
> -       hwmon_device_unregister(resource->hwmon_dev);
> +       if (!IS_ERR(resource->hwmon_dev))
> +               hwmon_device_unregister(resource->hwmon_dev);
>
>         remove_domain_devices(resource);
>         free_capabilities(resource);
> --
> 2.51.0
>
>
>

Hello, I tested this patch, but unfortunately it does not resolve the
reported issue on our systems the deadlock is still reproducible with
the same iDRAC reset reproducer.

Jaroslav Pulchart

