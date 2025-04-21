Return-Path: <stable+bounces-134888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2421A95906
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051D2161C08
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697D522126C;
	Mon, 21 Apr 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TLT1vEz5"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18921E0BE
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273252; cv=none; b=NNKtwiB+7BhrFvkgd6MBowPwX+1JVTwC+5rtnay/NBzKWgscgDpEic5Mqd5eUWqSMZeIsAFNL898S8jINBnpqR3hlEL3IYQtvLqbL4pgosKLiqx6YxjDRjGf6bpSm207SSGMA1XlFIGOtAQ4AXHCkTBrGotfRDEV41bT+dxPjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273252; c=relaxed/simple;
	bh=MzY6L7QZ1+YSe+vZIUCtymwnd9HnLUWDo3cjfbA0cYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XThtkVYkd44BVth/ocH31ZobrmC5+Lz2GlrFARzuyPFZyMGriWalITKhvqtQweQmo6JrOqcrYpdOGrc7nOCu1vtfP4uhvUKL4kBKloEmiyUxuEvnpy7u+Pv8VpSPZO3mS/NdGf3Mul7wchjZC1+szTH5auMNXw40b3pUTNhtX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TLT1vEz5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745273245; x=1745878045; i=w_armin@gmx.de;
	bh=L3J1Stao2crsHF9ZhM7uy9FEyH3vBIJJoCgDO586OFo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TLT1vEz5Wj/ZsWyJZyutDt7vMKsh/07vZNku/tvCuoZ7XH8HBZZ4oBdyzUsYLU3s
	 i9MPIGU1FydN6rTUNuW3+9LMtXq/J2tCbWWG4AITwvlx24ducm9KP7L6+nG8tmBpk
	 a92b5d3u4WkD05W9iplN99rsGgxZa3cpoctp6zB332nZliTcDdf8asn4zsbmvDUlZ
	 BCzz5tg7FFTVTWe+ANz2FfetPvoLdTC+TAhfrMOr6MbscndHt37S9DQWL6fIjfkQ/
	 yXYZ/zcFymXpalqLElZgg+Sr76Oq6HVpF0GdftPFrNzqGRLZUXtTz0JMWEPWDc9l9
	 bur06SXfbN0oAS2O1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1uX4u61Svj-00PHNL; Tue, 22
 Apr 2025 00:07:25 +0200
Message-ID: <c479afca-a994-4a65-a7c5-7fb53b2d38e9@gmx.de>
Date: Tue, 22 Apr 2025 00:07:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] platform/x86: msi-wmi-platform: Workaround
 a ACPI firmware" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
 lkml@antheas.dev
Cc: stable@vger.kernel.org
References: <2025042139-decimeter-dislike-3ca4@gregkh>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2025042139-decimeter-dislike-3ca4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wMle5D/SjsWVfEvoiTkP+LQiH4j1tHYyyer63SIZ0fneJ3B8KQt
 ly7Mn5FHfNZcTgXyAO4ubVmW8rVMpGYVXiltfQ+2t1QsHrozxa5zg/Gho1lljujAHDvqP1C
 diXL0ZfnHjZLmRT/Ex8j7AcugmoA7my82rqUoKuwsze2Kw1FmQMtS3wAxevWOUY0mv6d+ZM
 RTN4tFJGpcaXDdYWk4sow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ANGpNtCKlJw=;nzryhXb1vemJHKq8kJkha6PHlOo
 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
 sM9Q=

Am 21.04.25 um 16:03 schrieb gregkh@linuxfoundation.org:

> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following comman=
ds:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.g=
it/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x baf2f2c2b4c8e1d398173acd4d2fa9131a86b84e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042139=
-decimeter-dislike-3ca4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:

Hi,

this patch depends on 912d614ac99e ("platform/x86: msi-wmi-platform: Renam=
e "data" variable"). I thought that i signaled that
by using the "Cc: stable@vger.kernel.org # 6.x.x:" tag.

Where did i mess up?

Thanks,
Armin Wold

> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From baf2f2c2b4c8e1d398173acd4d2fa9131a86b84e Mon Sep 17 00:00:00 2001
> From: Armin Wolf <W_Armin@gmx.de>
> Date: Mon, 14 Apr 2025 16:04:53 +0200
> Subject: [PATCH] platform/x86: msi-wmi-platform: Workaround a ACPI firmw=
are
>   bug
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The ACPI byte code inside the ACPI control method responsible for
> handling the WMI method calls uses a global buffer for constructing
> the return value, yet the ACPI control method itself is not marked
> as "Serialized".
> This means that calling WMI methods on this WMI device is not
> thread-safe, as concurrent WMI method calls will corrupt the global
> buffer.
>
> Fix this by serializing the WMI method calls using a mutex.
>
> Cc: stable@vger.kernel.org # 6.x.x: 912d614ac99e: platform/x86: msi-wmi-=
platform: Rename "data" variable
> Fixes: 9c0beb6b29e7 ("platform/x86: wmi: Add MSI WMI Platform driver")
> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Link: https://lore.kernel.org/r/20250414140453.7691-2-W_Armin@gmx.de
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentat=
ion/wmi/devices/msi-wmi-platform.rst
> index 31a136942892..73197b31926a 100644
> --- a/Documentation/wmi/devices/msi-wmi-platform.rst
> +++ b/Documentation/wmi/devices/msi-wmi-platform.rst
> @@ -138,6 +138,10 @@ input data, the meaning of which depends on the sub=
feature being accessed.
>   The output buffer contains a single byte which signals success or fail=
ure (``0x00`` on failure)
>   and 31 bytes of output data, the meaning if which depends on the subfe=
ature being accessed.
>  =20
> +.. note::
> +   The ACPI control method responsible for handling the WMI method call=
s is not thread-safe.
> +   This is a firmware bug that needs to be handled inside the driver it=
self.
> +
>   WMI method Get_EC()
>   -------------------
>  =20
> diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/=
x86/msi-wmi-platform.c
> index e15681dfca8d..dc5e9878cb68 100644
> --- a/drivers/platform/x86/msi-wmi-platform.c
> +++ b/drivers/platform/x86/msi-wmi-platform.c
> @@ -10,6 +10,7 @@
>   #include <linux/acpi.h>
>   #include <linux/bits.h>
>   #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>   #include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/device/driver.h>
> @@ -17,6 +18,7 @@
>   #include <linux/hwmon.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/printk.h>
>   #include <linux/rwsem.h>
>   #include <linux/types.h>
> @@ -76,8 +78,13 @@ enum msi_wmi_platform_method {
>   	MSI_PLATFORM_GET_WMI		=3D 0x1d,
>   };
>  =20
> -struct msi_wmi_platform_debugfs_data {
> +struct msi_wmi_platform_data {
>   	struct wmi_device *wdev;
> +	struct mutex wmi_lock;	/* Necessary when calling WMI methods */
> +};
> +
> +struct msi_wmi_platform_debugfs_data {
> +	struct msi_wmi_platform_data *data;
>   	enum msi_wmi_platform_method method;
>   	struct rw_semaphore buffer_lock;	/* Protects debugfs buffer */
>   	size_t length;
> @@ -132,8 +139,9 @@ static int msi_wmi_platform_parse_buffer(union acpi_=
object *obj, u8 *output, siz
>   	return 0;
>   }
>  =20
> -static int msi_wmi_platform_query(struct wmi_device *wdev, enum msi_wmi=
_platform_method method,
> -				  u8 *input, size_t input_length, u8 *output, size_t output_length)
> +static int msi_wmi_platform_query(struct msi_wmi_platform_data *data,
> +				  enum msi_wmi_platform_method method, u8 *input,
> +				  size_t input_length, u8 *output, size_t output_length)
>   {
>   	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
>   	struct acpi_buffer in =3D {
> @@ -147,9 +155,15 @@ static int msi_wmi_platform_query(struct wmi_device=
 *wdev, enum msi_wmi_platform
>   	if (!input_length || !output_length)
>   		return -EINVAL;
>  =20
> -	status =3D wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
> -	if (ACPI_FAILURE(status))
> -		return -EIO;
> +	/*
> +	 * The ACPI control method responsible for handling the WMI method cal=
ls
> +	 * is not thread-safe. Because of this we have to do the locking ourse=
lf.
> +	 */
> +	scoped_guard(mutex, &data->wmi_lock) {
> +		status =3D wmidev_evaluate_method(data->wdev, 0x0, method, &in, &out)=
;
> +		if (ACPI_FAILURE(status))
> +			return -EIO;
> +	}
>  =20
>   	obj =3D out.pointer;
>   	if (!obj)
> @@ -170,13 +184,13 @@ static umode_t msi_wmi_platform_is_visible(const v=
oid *drvdata, enum hwmon_senso
>   static int msi_wmi_platform_read(struct device *dev, enum hwmon_sensor=
_types type, u32 attr,
>   				 int channel, long *val)
>   {
> -	struct wmi_device *wdev =3D dev_get_drvdata(dev);
> +	struct msi_wmi_platform_data *data =3D dev_get_drvdata(dev);
>   	u8 input[32] =3D { 0 };
>   	u8 output[32];
>   	u16 value;
>   	int ret;
>  =20
> -	ret =3D msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_FAN, input, size=
of(input), output,
> +	ret =3D msi_wmi_platform_query(data, MSI_PLATFORM_GET_FAN, input, size=
of(input), output,
>   				     sizeof(output));
>   	if (ret < 0)
>   		return ret;
> @@ -231,7 +245,7 @@ static ssize_t msi_wmi_platform_write(struct file *f=
p, const char __user *input,
>   		return ret;
>  =20
>   	down_write(&data->buffer_lock);
> -	ret =3D msi_wmi_platform_query(data->wdev, data->method, payload, data=
->length, data->buffer,
> +	ret =3D msi_wmi_platform_query(data->data, data->method, payload, data=
->length, data->buffer,
>   				     data->length);
>   	up_write(&data->buffer_lock);
>  =20
> @@ -277,17 +291,17 @@ static void msi_wmi_platform_debugfs_remove(void *=
data)
>   	debugfs_remove_recursive(dir);
>   }
>  =20
> -static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struc=
t dentry *dir,
> +static void msi_wmi_platform_debugfs_add(struct msi_wmi_platform_data *=
drvdata, struct dentry *dir,
>   					 const char *name, enum msi_wmi_platform_method method)
>   {
>   	struct msi_wmi_platform_debugfs_data *data;
>   	struct dentry *entry;
>  =20
> -	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
> +	data =3D devm_kzalloc(&drvdata->wdev->dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return;
>  =20
> -	data->wdev =3D wdev;
> +	data->data =3D drvdata;
>   	data->method =3D method;
>   	init_rwsem(&data->buffer_lock);
>  =20
> @@ -298,82 +312,82 @@ static void msi_wmi_platform_debugfs_add(struct wm=
i_device *wdev, struct dentry
>  =20
>   	entry =3D debugfs_create_file(name, 0600, dir, data, &msi_wmi_platfor=
m_debugfs_fops);
>   	if (IS_ERR(entry))
> -		devm_kfree(&wdev->dev, data);
> +		devm_kfree(&drvdata->wdev->dev, data);
>   }
>  =20
> -static void msi_wmi_platform_debugfs_init(struct wmi_device *wdev)
> +static void msi_wmi_platform_debugfs_init(struct msi_wmi_platform_data =
*data)
>   {
>   	struct dentry *dir;
>   	char dir_name[64];
>   	int ret, method;
>  =20
> -	scnprintf(dir_name, ARRAY_SIZE(dir_name), "%s-%s", DRIVER_NAME, dev_na=
me(&wdev->dev));
> +	scnprintf(dir_name, ARRAY_SIZE(dir_name), "%s-%s", DRIVER_NAME, dev_na=
me(&data->wdev->dev));
>  =20
>   	dir =3D debugfs_create_dir(dir_name, NULL);
>   	if (IS_ERR(dir))
>   		return;
>  =20
> -	ret =3D devm_add_action_or_reset(&wdev->dev, msi_wmi_platform_debugfs_=
remove, dir);
> +	ret =3D devm_add_action_or_reset(&data->wdev->dev, msi_wmi_platform_de=
bugfs_remove, dir);
>   	if (ret < 0)
>   		return;
>  =20
>   	for (method =3D MSI_PLATFORM_GET_PACKAGE; method <=3D MSI_PLATFORM_GE=
T_WMI; method++)
> -		msi_wmi_platform_debugfs_add(wdev, dir, msi_wmi_platform_debugfs_name=
s[method - 1],
> +		msi_wmi_platform_debugfs_add(data, dir, msi_wmi_platform_debugfs_name=
s[method - 1],
>   					     method);
>   }
>  =20
> -static int msi_wmi_platform_hwmon_init(struct wmi_device *wdev)
> +static int msi_wmi_platform_hwmon_init(struct msi_wmi_platform_data *da=
ta)
>   {
>   	struct device *hdev;
>  =20
> -	hdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "msi_wmi_pla=
tform", wdev,
> +	hdev =3D devm_hwmon_device_register_with_info(&data->wdev->dev, "msi_w=
mi_platform", data,
>   						    &msi_wmi_platform_chip_info, NULL);
>  =20
>   	return PTR_ERR_OR_ZERO(hdev);
>   }
>  =20
> -static int msi_wmi_platform_ec_init(struct wmi_device *wdev)
> +static int msi_wmi_platform_ec_init(struct msi_wmi_platform_data *data)
>   {
>   	u8 input[32] =3D { 0 };
>   	u8 output[32];
>   	u8 flags;
>   	int ret;
>  =20
> -	ret =3D msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_EC, input, sizeo=
f(input), output,
> +	ret =3D msi_wmi_platform_query(data, MSI_PLATFORM_GET_EC, input, sizeo=
f(input), output,
>   				     sizeof(output));
>   	if (ret < 0)
>   		return ret;
>  =20
>   	flags =3D output[MSI_PLATFORM_EC_FLAGS_OFFSET];
>  =20
> -	dev_dbg(&wdev->dev, "EC RAM version %lu.%lu\n",
> +	dev_dbg(&data->wdev->dev, "EC RAM version %lu.%lu\n",
>   		FIELD_GET(MSI_PLATFORM_EC_MAJOR_MASK, flags),
>   		FIELD_GET(MSI_PLATFORM_EC_MINOR_MASK, flags));
> -	dev_dbg(&wdev->dev, "EC firmware version %.28s\n",
> +	dev_dbg(&data->wdev->dev, "EC firmware version %.28s\n",
>   		&output[MSI_PLATFORM_EC_VERSION_OFFSET]);
>  =20
>   	if (!(flags & MSI_PLATFORM_EC_IS_TIGERLAKE)) {
>   		if (!force)
>   			return -ENODEV;
>  =20
> -		dev_warn(&wdev->dev, "Loading on a non-Tigerlake platform\n");
> +		dev_warn(&data->wdev->dev, "Loading on a non-Tigerlake platform\n");
>   	}
>  =20
>   	return 0;
>   }
>  =20
> -static int msi_wmi_platform_init(struct wmi_device *wdev)
> +static int msi_wmi_platform_init(struct msi_wmi_platform_data *data)
>   {
>   	u8 input[32] =3D { 0 };
>   	u8 output[32];
>   	int ret;
>  =20
> -	ret =3D msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_WMI, input, size=
of(input), output,
> +	ret =3D msi_wmi_platform_query(data, MSI_PLATFORM_GET_WMI, input, size=
of(input), output,
>   				     sizeof(output));
>   	if (ret < 0)
>   		return ret;
>  =20
> -	dev_dbg(&wdev->dev, "WMI interface version %u.%u\n",
> +	dev_dbg(&data->wdev->dev, "WMI interface version %u.%u\n",
>   		output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
>   		output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
>  =20
> @@ -381,7 +395,8 @@ static int msi_wmi_platform_init(struct wmi_device *=
wdev)
>   		if (!force)
>   			return -ENODEV;
>  =20
> -		dev_warn(&wdev->dev, "Loading despite unsupported WMI interface versi=
on (%u.%u)\n",
> +		dev_warn(&data->wdev->dev,
> +			 "Loading despite unsupported WMI interface version (%u.%u)\n",
>   			 output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
>   			 output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
>   	}
> @@ -391,19 +406,31 @@ static int msi_wmi_platform_init(struct wmi_device=
 *wdev)
>  =20
>   static int msi_wmi_platform_probe(struct wmi_device *wdev, const void =
*context)
>   {
> +	struct msi_wmi_platform_data *data;
>   	int ret;
>  =20
> -	ret =3D msi_wmi_platform_init(wdev);
> +	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->wdev =3D wdev;
> +	dev_set_drvdata(&wdev->dev, data);
> +
> +	ret =3D devm_mutex_init(&wdev->dev, &data->wmi_lock);
>   	if (ret < 0)
>   		return ret;
>  =20
> -	ret =3D msi_wmi_platform_ec_init(wdev);
> +	ret =3D msi_wmi_platform_init(data);
>   	if (ret < 0)
>   		return ret;
>  =20
> -	msi_wmi_platform_debugfs_init(wdev);
> +	ret =3D msi_wmi_platform_ec_init(data);
> +	if (ret < 0)
> +		return ret;
>  =20
> -	return msi_wmi_platform_hwmon_init(wdev);
> +	msi_wmi_platform_debugfs_init(data);
> +
> +	return msi_wmi_platform_hwmon_init(data);
>   }
>  =20
>   static const struct wmi_device_id msi_wmi_platform_id_table[] =3D {
>

