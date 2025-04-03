Return-Path: <stable+bounces-127477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE03A79BBF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 08:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F86C17019E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 06:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F7E19E98C;
	Thu,  3 Apr 2025 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="ODokm+X4"
X-Original-To: stable@vger.kernel.org
Received: from enterprise02.smtp.diehl.com (enterprise02.smtp.diehl.com [193.201.238.220])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2225746E;
	Thu,  3 Apr 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660446; cv=none; b=hZ6LkpMDf+diP1twWTyc/M2oLOStW06NNcgyxPBw2MS84Ljb/vS7aqyblNc/1eoboqLCovv9TtLrGRsNiDoL+vtUN2xGpCMQmKb9z57skiWDESsoZ3RSeH2jXgqQLUOsHdIcYdTc4zQgcRg7wRjdGscoROO/TgdSI+8KEFX5YYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660446; c=relaxed/simple;
	bh=aA0iQs3ts1utRTkgh5ha/WaoU4byspJU4GI8o3vuAuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6epu+n12nJaSPq7a3aF9BhehdrZPeGaLFWL5eYDtHYy77GxNRv/dIs2Y0c60Z4EL63+rRWAPyPH5BrASEfdsmjv9xnhj9xCEaKOKEJ2xzJm1tP/Z2iIe7tIRxvf3N0k6SJQm6FV/iPgDPG5R1DvDwjBgjeHP9TRzQH9EUweIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=ODokm+X4; arc=none smtp.client-ip=193.201.238.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1743660443; x=1775196443;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=UnLYfXmFW2Vs4rr8XQwABwmsEO1AgOUz99RfI7TUe78=;
  b=ODokm+X4HIcKzwKb3//nqyMl/cHH4U5N5hjCq3BJemixz40H9y+xhiDk
   MZYUPu1IFzGHsUabnd9uiGkssnTj0tpXwEOQyQp20I2uMCcShrFdKRCm8
   +YXW+C5JKNFfx5f4KXuekDb7T4fjxO8wdwUlb2KZpdeZmHzy2FZvHrkgq
   wATfAKr83EOi9FyB7Qum3ZxUWRATv+/C8TgUFm1C4zgg/at+gmOKVt6sz
   HV4qL2sbtr2UXheZ3Tw+RA9tVGOo0/S8PssFrCeGfnhwxf/YZJkJ2vovk
   /lU16fS8BfPbgD62lhusWbIE2x4Pin/0/AErA881bH/N0Tj+5LYhTpHt3
   Q==;
X-CSE-ConnectionGUID: VohUttw3Qh+zBbat5idriQ==
X-CSE-MsgGUID: P2BEOe0TTsGflZqL5kpnvg==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:nzE9Q61y92x0OkpRVPbD5RR2kn2cJEfYwER7XKvMYbSIpGtil2len
 TNbADbYJbeXIjmmON5rK9ThqxtC/NSA/mJROEEx9HRgCWoVsqIpbvzFc0z7NHjCJ5bNQR435
 MxDN4WYdJ5uHyGDrE7wPLK6oSd3jvuGS+P1BrfKMH8gTFY0EXl70kMzx7M024IwjYLga+/hk
 drqu8neM1a52jlydXoX4Lnc7Qhus/L7pC4CszTSQNgS1LOJvydNV8J3ydiNB3vkXpEGWamzR
 u+F16645XjC/hgrTNil1b/6aAhQHLeNZAPW2z8KBKWox0Qf+yV3g6xhZL9AY0sI0TmHx4Erm
 NkVj9/ow+/hEK3QhPxPFF5fGDpme7ZZ+aTcOnmwt4qYzwrdcnTqhPJlFwQ/NIYT8et7XCQQq
 /FIbWxVMEHG1ujvyve1RrM9j858d8TlMYhHoEwI8d2iNhpQfHy5a/6Mvbdl9DcsmtgcWrHXZ
 sNfciVudw/bYhJJfFwXT5s/hqL0jybxKmII+BfP+6BqpjSDwQc02eWxb5/eI9eGHc9bxxmT/
 W6ewgzF7moh2KqiJUCtqTT07tLnnT/nQNBVU7ai8rhxn1yI3XcSBxtQXlv8qvWhzxWzVo8CJ
 UBIv3d/9vh3qBWmQ5ytBRGy5SXe5EUVUNdeTuZgs1mwopY4mD11cFXoNBYaLoROiec2WSAyh
 BjOlMntQydwsaaOUnOS8PGfrXS5NTBQID5da3dbRldA7oe4/MRvhR/EC4ZuSqfw1oH/Q2n5n
 DnR9CNj34h7sSJw7EnNwLy9q2nq/vD0czMICiXrskONsggjOdGrbdTxuVaAsa8Yct2SEwnZ4
 CEOxZDCsOlUVp3RzXzcS+gzR7z4vPzt3B8wI7JMN8R7q279qybLkaR4umwWyJJBa55cEdPRS
 BaN/1sXvNkLYSfCgZZfO+qZE94twbXrCePrX/XVassmSpVqfWdrxgk3DaKr9z6ryRVEfZ0XY
 8/BLJ7wVS1CUMyL8RLtLwsj+e5yrswB7TOLLXzL50zP+aaTYneTVYAEPDOmBsgl7LmJqRni6
 N1WMc2H0X13CIUStQGOrOb/hXhTRZQKLcieR/5/L4ZvESI/cI0VMMI99Jt6E2BTcwa5oc+Tl
 p21chcwJFMSHhQrIy3SApxoQOuHsZqSMRvXlMHjVLql8yFLXGqh0EsQX6UwfYQ76PM49P43X
 dMPctndA/hVSw2SrlzxbbGlxGBjXBiulwmBIHL/JjM4ZYYmSw3E+tuidQzqnMUMJnPv85tk5
 eTwkFqAG/LvRCw7ZCrSQP6iyVKq+38GhO9oW0LOLvFfeUjs9M5hLCmZYvofephVd0Wdm2PGv
 +qQKS9Cj8TqrtcJzMLmi6S2tqP0EPN4AEUPSgE36p7zb0E25FGLzo5HVeuUYTH1WWXy9aikY
 +gTxPb5WNUDnVBXo89/HqxtwKYW+dTivflZwx5iEXGNaE6kYpt7PnCM2cRnqKJA3PlatBGwV
 0bJ/cNVUYhlI+u8SBhBfkx8PqLajqt8diTu0MnZ6X7SvEdflIdrm20LV/VQoESx9IdIDb4=
IronPort-HdrOrdr: A9a23:HtrRyaDy0IAruGPlHeme55DYdb4zR+YMi2TDj3oBKyC9Afbo8v
 xG/c5rrSMc5wxwZJhNo7290cq7MAjhHPxOkOos1N6ZNWGM0ldAR7sM0WKW+Vzd8lrFmNK1u5
 0NT0E0MqyVMbEzt7ec3OG1fuxQpuVv3prY/Nvj8w==
X-Talos-CUID: =?us-ascii?q?9a23=3A0cr2I2jrfPpwmJd61ylV8JtrTzJuTHrd8WvMPBS?=
 =?us-ascii?q?BCSV7YrecVQKR9Lllqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AAHVlyQy0sB0XmpL11xzmUQc38FCaqJz0Im0qnM0?=
 =?us-ascii?q?6h9KrOyhCIhPAjyyxXIByfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.15,184,1739833200"; 
   d="p7s'346?scan'346,208,346";a="111686504"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: Re: [PATCH] pps: fix poll support
Date: Thu, 3 Apr 2025 08:06:11 +0200 (CEST)
Message-ID: <0231dfc22dd34a5aaee09a6a19074de1@diehl.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----3114280830094A253D2C1164C362EE67"

This is an S/MIME signed message

------3114280830094A253D2C1164C362EE67
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Rodolfo,

Do you think that there is a chance that this patch make it in the current merge window?

Regards Denis

-----Original Message-----
From: Rodolfo Giometti <giometti@enneenne.com> 
Sent: Monday, March 3, 2025 12:54 PM
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org; Denis OSTERLAND-HEIM <denis.osterland@diehl.com>; stable@vger.kernel.org
Subject: [EXT] Re: [PATCH] pps: fix poll support

[EXTERNAL EMAIL]
 

On 03/03/25 09:02, Denis OSTERLAND-HEIM wrote:
> [BUG]
> A user space program that calls select/poll get always an immediate data
> ready-to-read response. As a result the intended use to wait until next
> data becomes ready does not work.
> 
> User space snippet:
> 
>      struct pollfd pollfd = {
>        .fd = open("/dev/pps0", O_RDONLY),
>        .events = POLLIN|POLLERR,
>        .revents = 0 };
>      while(1) {
>        poll(&pollfd, 1, 2000/*ms*/); // returns immediate, but should wait
>        if(revents & EPOLLIN) { // always true
>          struct pps_fdata fdata;
>          memset(&fdata, 0, sizeof(memdata));
>          ioctl(PPS_FETCH, &fdata); // currently fetches data at max speed
>        }
>      }
> 
> [CAUSE]
> pps_cdev_poll() returns unconditionally EPOLLIN.
> 
> [FIX]
> Remember the last fetch event counter and compare this value in
> pps_cdev_poll() with most recent event counter
> and return 0 if they are equal.
> 
> Signed-off-by: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

If needed. :)

> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
> CC: stable@vger.linux.org # 5.4+
> ---
>   drivers/pps/pps.c          | 11 +++++++++--
>   include/linux/pps_kernel.h |  1 +
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 6a02245ea35f..9463232af8d2 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
>   
>   	poll_wait(file, &pps->queue, wait);
>   
> +	if (pps->last_fetched_ev == pps->last_ev)
> +		return 0;
> +
>   	return EPOLLIN | EPOLLRDNORM;
>   }
>   
> @@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
>   		if (err)
>   			return err;
>   
> -		/* Return the fetched timestamp */
> +		/* Return the fetched timestamp and save last fetched event  */
>   		spin_lock_irq(&pps->lock);
>   
> +		pps->last_fetched_ev = pps->last_ev;
> +
>   		fdata.info.assert_sequence = pps->assert_sequence;
>   		fdata.info.clear_sequence = pps->clear_sequence;
>   		fdata.info.assert_tu = pps->assert_tu;
> @@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
>   		if (err)
>   			return err;
>   
> -		/* Return the fetched timestamp */
> +		/* Return the fetched timestamp and save last fetched event  */
>   		spin_lock_irq(&pps->lock);
>   
> +		pps->last_fetched_ev = pps->last_ev;
> +
>   		compat.info.assert_sequence = pps->assert_sequence;
>   		compat.info.clear_sequence = pps->clear_sequence;
>   		compat.info.current_mode = pps->current_mode;
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index c7abce28ed29..aab0aebb529e 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -52,6 +52,7 @@ struct pps_device {
>   	int current_mode;			/* PPS mode at event time */
>   
>   	unsigned int last_ev;			/* last PPS event id */
> +	unsigned int last_fetched_ev;		/* last fetched PPS event id */
>   	wait_queue_head_t queue;		/* PPS event queue */
>   
>   	unsigned int id;			/* PPS source unique ID */

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

------3114280830094A253D2C1164C362EE67
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIXkgYJKoZIhvcNAQcCoIIXgzCCF38CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgghPaMIIGpTCCBI2gAwIBAgIUPseeE9qJ+oSdbny5LvEHTpzUCAIw
DQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCQ0gxFTATBgNVBAoTDFN3aXNzU2ln
biBBRzEtMCsGA1UEAxMkU3dpc3NTaWduIFJTQSBTTUlNRSBSb290IENBIDIwMjIg
LSAxMB4XDTI0MDUyODA4NDExMFoXDTM2MDUyODA4NDExMFowUjELMAkGA1UEBhMC
Q0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEsMCoGA1UEAwwjU3dpc3NTaWduIFJT
QSBTTUlNRSBNViBJQ0EgMjAyNCAtIDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
ggIKAoICAQC6Dz+IfbUsaCl0cWcbnNS1BIaKrdka8ev1Kc1G6OCYH4PMtkZmC6Zo
nnh/Dl5bOuiH+pMq1fj4BSEkRYTuOGtsWelcf6UNA11KL//zh1enaaNayqqRaCSE
JTZH+JFb0UJWwO+qGVb1RfHnPXYrI6n8w1chCxL9AibzvsDPR6I37iUwiNo4p6Uo
aPNAmIncpDIGgTGodkOjjPPbGwYjg58eINT63rqMQASJxUnPPIa0gZRix0NY7A6U
z8Iv98RbbQy7ZEDvHdLFeVmzl/5TXKbQExfnEpyOjjifWoJ+FeKkEj4O9Ohd/2fg
HQ6Y+DYwLFbHZPTmDvHQoOSS//V2NBkdnGTsfIcziIH1hypFxR/hqexJ+Da7Z7uN
jBh2ligdXNHDGMeq640X2WVx0sfSZljxbeknrr3KFfzqfealPps1UI68Q+1iBLl/
Ep8aZeRmzwCK+ibAPQpKfbxsjd8cBe8FcXaOWU4DjP6YmYy0xMC4vHXr3ZgrHqL9
8D56InfiYbrBMZp1UKDSzlz/rjXWRmrXnsY5gFU705KWrJu2guSYCrc4InG3Pj+E
mPmE6Eosikk2wg90nYFxJDM/9dPJnyIw6IdkV6qdrv9h7VKrpLrl22qETWC4/Xfi
JU7YsY6HFKnpAElKu8t6rUnU5GcwgWjcB+zBfQD1Kt59jlLob2PcDwIDAQABo4IB
cDCCAWwwXAYIKwYBBQUHAQEEUDBOMEwGCCsGAQUFBzAChkBodHRwOi8vYWlhLnN3
aXNzc2lnbi5jaC9haXItNGE3ZjE3ODgtMjZiNS00OGVjLWE1NDctYzFjZDBiZjE3
YzNkMBIGA1UdEwEB/wQIMAYBAf8CAQAwQAYDVR0gBDkwNzAJBgdngQwBBQEBMAkG
B2eBDAEFAQIwCQYHZ4EMAQUBAzAIBgYEAI96AQMwCgYIYIV0AVkCAQswUQYDVR0f
BEowSDBGoESgQoZAaHR0cDovL2NybC5zd2lzc3NpZ24uY2gvY2RwLTNlZTU1ZmQ0
LTU5MzgtNDFlZS04MmRiLTMyMjNhY2VmNWMyMzATBgNVHSUEDDAKBggrBgEFBQcD
BDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFL+0FkGip5/XTYUBCqFcvtvF0uWU
MB8GA1UdIwQYMBaAFMwurYmMg+NAoyVppeqSfdI3OsfGMA0GCSqGSIb3DQEBCwUA
A4ICAQBGpYYvkjNsVP7geKv1jY+KtUNmyx8vlCoOo8tZ5Cc76175ocrVs50lZit+
nHWXe9Lqnuu1fMo+0jEpgC9dqy6cCxAEgNH5kwbFxXFPHOB/kxMdWubZ1xwcOP2l
B4ns7Ps9RUGOIcpfuAp2KLYwavjO58g+6FVGhY3R6VAhmNRO6bHhz0wQRwKAZNo2
GMwYMmxW63mI4bz1JYvCSeZtqZhyxTMDOwEUDdYkxrz3g5gQUoMnrrak1kGRdpFB
Eefok8aK8ngfwwIgefNBF9BnzoRhlIVrm3//zboqShj4IXqMEUgScWNz2WTjqKaU
uhLk+MyynNqrbp6EeFZ0BPgA7AfVWevRf4OOCxrH6S4FJtMKmuczZ0wqebTML7Ax
VtkSqeT7/NBDTh8D8j+HVvHwMi4s+cunS3DMdXE9yzuixlcjfsD/2aS17quE23Qf
nNESdDy5TUs5Wlm1ClYQ+L1cZGwSwAyqMs9RNg57+gtJu5Uhjn+FGVLndGQgzIor
/+ynq6KEzN2rhGzLpPHpwUdDoX+YnNlrZpdx/IOgknaSGznJ/mQzA6PjffNS0Fx3
pqd41QO0uX5HWDFEa/gG0Uo7faymzXFcFb9AKCrKR5Xrd0W+f2U2z/hvC843i9q2
8CoJ7xRMt0wF8Sun9U278iaLgPNNyCNDJorz9NmIomvT45XK7jCCBe4wggPWoAMC
AQICEACzBRGxFrSgVlEdfGgfh30wDQYJKoZIhvcNAQELBQAwRTELMAkGA1UEBhMC
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
bIRutw/gmkT7b9aP2Wmm3PtjnasrM+RdDlfGKqHkeCR2zkeRDDP2BE2LKc9CFGJB
PysNjZSVlp5/fxb8atVwVk+TphIHuHjeP+3z/ykiDr64Yq2yjyNlXrWVg2yxju4M
LdX8wfkCx/uAIlYLACinK+/RATAYz1f3Y+kJ81CQbfFpnFZBRhxjDfj65zxMrWsJ
ydnoGsZUHt7zXFOQvw7JrFL/X5s7hBv/3uy107vBwcA8Hyw9m3DH/ChBMen6gyy+
CkNXalP9AOZ66CoEgIE8PfsrzfBVjVxQq2+iQLNlJ8a1r6URPNd5h1YZILBy6yTK
8tUs5MbM2CjbXAylEC1P02GFKhh/aN0gW5RTRk3vpA64KPQ/ckvUTmHVWONUE9cj
iE1/MVDuc+tMfQus2HBQ0LH+EKaVZmsA1OEKujelRFleMEpBBWS0fQ+zT2Y4bfPZ
RB5iQLGLf9hSacG+ib5cid44OL6s9kjzE5+Yy70LNcoHwIaQzqoc6t7sFNVDecMc
tTbrs+raTu/cOMSc45aEDKXjhYw46cyuLwnY9DauweK3K89jUrCNqNqPwQke6QID
AQABo4ICCzCCAgcwgbIGCCsGAQUFBwEBBIGlMIGiMEwGCCsGAQUFBzAChkBodHRw
Oi8vYWlhLnN3aXNzc2lnbi5jaC9haXItMjZhNzFjMDktNDdlYi00NTVhLTliMjgt
NGJkNzJkZjA5MjhkMFIGCCsGAQUFBzABhkZodHRwOi8vb2NzcC5zd2lzc3NpZ24u
Y2gvc2lnbi9vY3MtYWFjY2NlZDUtNjZlOC00MDY5LTliMWItZmQyOWFiNzNlZmVj
MHIGA1UdIARrMGkwCQYHZ4EMAQUBATAIBgYEAI96AQMwUgYIYIV0AVkCAQswRjBE
BggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dp
c3NTaWduX0NQU19TTUlNRS5wZGYwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL2Ny
bC5zd2lzc3NpZ24uY2gvY2RwLWU5N2YwN2M0LWU2MzQtNGNlYy04ZTJhLTA0YjIw
YTdhMzBjNTATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBaAwJAYD
VR0RBB0wG4EZZGVuaXMub3N0ZXJsYW5kQGRpZWhsLmNvbTAdBgNVHQ4EFgQUcDNC
rQBRcB88zSaXlCXZiARXNi8wHwYDVR0jBBgwFoAUv7QWQaKnn9dNhQEKoVy+28XS
5ZQwDQYJKoZIhvcNAQELBQADggIBAGERoOSFwVyjYxyHmyClfw+npR6u+lM65HIH
REUcqiHtzZWVg5fFgcvp4aSgnHDl/LA+cZh1c8oymzZ5NJK7OGUEK3IpcIVhjFl7
ST/cg29MZy/5C8rWMWWXLjNxaepRN8e0zCxdGSm0nL5qUlPnREay35c19edhvgog
IBywGTMpVpWvkKkm0XW1q+yK7Nu17UbdlFzPFvIuuvxU/ytTK3V7UCTzZQeRzsuy
4Nn67ulycgMuVgVnhC8ar1imejfNMTORfcHz+MavkBbEp4IHh3ZGTd6R3U2KWkod
e2VnU3pGWD7GUefrUHyyRlIVjdnWbSnCrbdpc2BznYl8PbVHcipRvq3BRSfC5j4t
MOlGJ779WrFLEiEvu8iNUtAAd6/ha8vQRelTHE0HZWDWeND/NYPemmaK7waicfa+
TXbGEi3HkaJWmy266iw2SEEHYszzeFJVq8uRjxFUdOCRZvsfD6yoY6hchKoXRpkW
v8oW5LUTlhNfUZT2lRhkCwDdXh1wWzZgZZtx1VmVvYgfQg0RxMVdtqOsj4wpDkUU
dqnPfobQPmOxrrHqpwLH4sprjIBVmbAIVOHgyhlN31RbUcdyCsRqLIK4srhv1Qqj
IdMcphv3O2TqF/2mE64g/uinQq7uVqo7Yy0XDATNQ2g4gv/wliv5raoo7geyVNqJ
kT04CA2CMYIDfDCCA3gCAQEwajBSMQswCQYDVQQGEwJDSDEVMBMGA1UEChMMU3dp
c3NTaWduIEFHMSwwKgYDVQQDDCNTd2lzc1NpZ24gUlNBIFNNSU1FIE1WIElDQSAy
MDI0IC0gMQIUcJ9Pf3gC81On6JsQ/RWezTqDIbUwDQYJYIZIAWUDBAIBBQCggeQw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwNDAz
MDYwNjExWjAvBgkqhkiG9w0BCQQxIgQghzPCgifHuMp3G4+KsWF2g42G0od6sMha
HU2PGFSAjeEweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYI
KoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEB
BQAEggIAAbOHEsRfS3EGTqOqdNLpyzp6y1iCBt2bkgEnEK3P/bMpxWlwrh+zoe8E
GglPcpGvN/29XijeleJRd6fSrTs4feQ+xZfB1t6nbNvjq/HUH6usnmvg9cHvv7Bs
xgcjzem3v8fkRguR0Dz8S1bttBkjMX4W+NzK+xf5B5j2fgJ5zPjeKkaaMrgXvMdh
r0dBzZl841bInFwMip+whDI0cNikPqolrx3kyuDsnKK0MpvHty9FwPvZeWBuFS7k
iGc3TTKgOWU0w6+x/3M/OdENC7Sg/xu548oxI2+rWw35S/7LWSC3fuLAAcGGpaK/
GNW2wZlhEzrmmjYbAONiwxole3CC7WsHXYy6UoZL6lrkX/rCYesc616PnHuhimGy
HNVUoo6yk7OvFWG6GiFrWaNEETQWmJdDgWN5CmwH80vByzxxsbFVHI7Hqedxk6a4
/Os2R7eTIX0PK3XG4olTnX7YKTKOIgHBKvp3S99UCg4wZBB+3OaUAwEXudETS5Ku
WZHHPY5o26RPeI67lhf1GaupODJc95FNUZodnBXfEturTLLPaynyysHX7lDpshno
sq1XPBxqKTXGajuS8Z5PoHaFniQ5YYw9i+XWKOsFLH0uuYc6GGcLwxeAJPrEzWOi
+aIc7oZzTG6vmcti9Eypn/88kwpNmEt9FN7amsOw8bRqBSdufeg=

------3114280830094A253D2C1164C362EE67--


