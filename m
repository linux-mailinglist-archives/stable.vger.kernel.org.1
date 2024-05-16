Return-Path: <stable+bounces-45302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59638C78CA
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 16:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019411C2134D
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA114B96A;
	Thu, 16 May 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ksaherUH"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0634146D7F;
	Thu, 16 May 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871440; cv=none; b=Rqr4UyMxWakWvi+DOZMdcFKnVHbkp19FUk1OWq3T3QfqwIO4W415bHixwGsZ+sWXf5zh/hjRCG10LX1neLMdkBQGxRAg2xDkaO0ThAhgVZUSZEgn5NvNagVkS9e8nlF9tym4JvcB9ne5GhRyffzwdprIzOfHH14oAhWPpwaywQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871440; c=relaxed/simple;
	bh=GDsm3h/IcVDrPZBroUZRxpkn4pFPy1u/7Ui0+oUlALk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEQ7HvWIJ1hbgm/ijMwaVeMnGKrSH570ueOt3/J7uVMe6PU8EzKABDUokHOClRFYx6lqHqCSUXeLAc7gp5eStxvXIfDDe/fSb4DORtZvv1o2CtFHGrydQnbWlq9ZwYaiTBkyHKJF2PgwyWeEHXF/KB4JTwy3xLbhhFFuX+iS4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ksaherUH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=tfyLnpZVWwLnHmF639fNbdaFAOdB0N4LYCqcFVqG7cU=;
	b=ksaherUHCSAskro6zB/RNWlVjKnvaYMrMn8v65pAu2yb4NOzxxdcYjZEQ6IrBZ
	X4p4blgZBBbzPeqUqbyPaAgLuHobaCKZKmohp4JtE7n97vG64Ptr55pIPqZbAhEc
	7cYx+AYiFwrMsx8OJjkH5bXwqqoKQQ0Af/f4gpTu4ay68=
Received: from [192.168.1.25] (unknown [183.195.4.13])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3n59eHkZmdIodEw--.60785S2;
	Thu, 16 May 2024 22:55:28 +0800 (CST)
Message-ID: <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com>
Date: Thu, 16 May 2024 22:55:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de,
 krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3n59eHkZmdIodEw--.60785S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1kGr4Dtw4xKF4rZF43Wrg_yoWrtFy5pF
	WqgFyakrWUJr97CFnrAw4xWFy5Zwnav3y3urW7K345JaySyrZ8GF4xt3y5Aa4UCryUCr4j
	qFnrX34UKas09F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Hq7UUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiEwbgNWXAlLRsnwAAs2



On 2024/5/16 21:31, Zijun Hu wrote:
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> 
> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
> by adding condition to avoid the serdev is flushed or wrote after closed
> but also introduces this regression issue regarding above steps since the
> VSC is not sent to reset controller during warm reboot.
> 
> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled, and the use-after-free issue is also fixed by
> this change since the serdev is still opened before it is flushed or wrote.
> 
> Verified by the reported machine Dell XPS 13 9310 laptop over below two
> kernel commits:
> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
> implementation for QCA") of bluetooth-next tree.
> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
> implementation for QCA") of linus mainline tree.
> 
> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
> Cc: stable@vger.kernel.org
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
> V1 -> V2: Add comments and more commit messages
> 
> V1 discussion link:
> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#t
> 
>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0c9c9ee56592..9a0bc86f9aac 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct device *dev)
>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>  	struct hci_uart *hu = &qcadev->serdev_hu;
>  	struct hci_dev *hdev = hu->hdev;
> -	struct qca_data *qca = hu->priv;
>  	const u8 ibs_wake_cmd[] = { 0xFD };
>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>  
>  	if (qcadev->btsoc_type == QCA_QCA6390) {
> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
> -		    !test_bit(HCI_RUNNING, &hdev->flags))
> +		/* The purpose of sending the VSC is to reset SOC into a initial
> +		 * state and the state will ensure next hdev->setup() success.
> +		 * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that
> +		 * hdev->setup() can do its job regardless of SoC state, so
> +		 * don't need to send the VSC.
> +		 * if HCI_SETUP is set, it means that hdev->setup() was never
> +		 * invoked and the SOC is already in the initial state, so
> +		 * don't also need to send the VSC.
> +		 */
> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
> +		    hci_dev_test_flag(hdev, HCI_SETUP))
>  			return;
>  
> +		/* The serdev must be in open state when conrol logic arrives
> +		 * here, so also fix the use-after-free issue caused by that
> +		 * the serdev is flushed or wrote after it is closed.
> +		 */
>  		serdev_device_write_flush(serdev);
>  		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>  					      sizeof(ibs_wake_cmd));
i believe Zijun's change is able to fix both below issues and don't
introduce new issue.

regression issue A:  BT enable failure after warm reboot.
issue B:  use-after-free issue, namely, kernel crash.


For issue B, i have more findings related to below commits ordered by time.

Commit A: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure
after warm reboot")

Commit B: de8892df72be ("Bluetooth: hci_serdev: Close UART port if
NON_PERSISTENT_SETUP is set")
this commit introduces issue B, it is also not suitable to associate
protocol state with state of lower level transport type such as serdev
or uart, in my opinion, protocol state should be independent with
transport type state, flag HCI_UART_PROTO_READY is for protocol state,
it means if protocol hu->proto is initialized and if we can invoke its
interfaces.it is common for various kinds of transport types. perhaps,
this is the reason why Zijun's change doesn't use flag HCI_UART_PROTO_READY.

Commit C: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
closed serdev")
this commit is to fix issue B which is actually caused by Commit B, but
it has Fixes tag for Commit A. and it also introduces the regression
issue A.


