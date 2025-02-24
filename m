Return-Path: <stable+bounces-118917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1FA41F3A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A201884D80
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E9221F32;
	Mon, 24 Feb 2025 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="H3AfyS2h"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A511A3174;
	Mon, 24 Feb 2025 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400647; cv=none; b=T4xZYg9xDrjO3C91K4/OC4hYByzOuPr014vCrTUaHlrmESQMJr/AoFM7Ew0cWizgJdwvMm6M1JB7H8YXIvR6ACLJXrauLUe6sjmTjvgtxjz1gXLsLCsXDP+AC2vNpcopjwLygpQG8AGILMflHiRW3igqLyX6Yb3jpWfWO1lQsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400647; c=relaxed/simple;
	bh=1Poe4jtjFciCF/B6DnMBl0Zl5tC3WTEGJawg5rMyuvI=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=vCDyAW1Vllj8UItGzV+Y+ygubgBXRxWObEJMi44QYHOycXQpMiiJiCEj7sEKSibzT5rZkiUgg/hFTE/vFqU7gp0PMRXXNAVpyXzyu3anw7gWM2bSNtlEy0SVA+SGOeojgTXKyNrIBm16xALL4eiogDNsUxOhuB+ZD/N1s/qWwyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=H3AfyS2h; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740400583;
	bh=1Poe4jtjFciCF/B6DnMBl0Zl5tC3WTEGJawg5rMyuvI=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=H3AfyS2hGbRW5GMwt0pfXJEkwuRZRRp3eeXbmhrGky6RtojUrDQ9QbP+ItMVqdMru
	 m/BRlQNq6wVWxN8IOVnBZn/8VetkpB1Z/l7FlePnoy5qPQz62aO38mRC80jfQojWNL
	 Q5c0Kc7ygbuJQJg4II4jL1vFzrVrJxU2n/ztHrNA=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: /kCXL7YdCMAQMJp2EF9RmB70KMGKaeAcRrkGDT1kSGk=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1740400581t9672772
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?Sm9obiBLZWVwaW5n?=" <jkeeping@inmusicbrands.com>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?RmVycnkgVG90aA==?=" <ftoth@exalondelft.nl>, "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re:[PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 24 Feb 2025 20:36:20 +0800
X-Priority: 3
Message-ID: <tencent_09E5A20410369ED253A21788@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
In-Reply-To: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
X-QQ-ReplyHash: 1598585841
X-BIZMAIL-ID: 2831296492139419663
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 24 Feb 2025 20:36:22 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NgGFmHr5W5/zh7bE9KrMuCq8Jj3f00WtpD2DVTgy02QuVBn5XasCz/0l
	/agOwrCbq4lmi9K4lTgtYTDRG78IZDo2wNNX/HsIJYkX8FFyzxbPo12uZm6Iv17T8NY9nLF
	OhhYB8MTumH3CTVCWcUctroTyTAQD4teJWc+tcpFbuhPCXBxOQW3xTONwwAP17UoSFJmy1t
	8Da/yNNRuLFIuY8PZDIys0b1CxNsAzFJ9EbOvIKNu4cF2P1un6skEjlQRMYA032MpDHCQ/E
	+DzteTpjdbWcYj95MAnVV3m6EryhmBXn+aGSdnFAVIxilQob2/nM/F/BZwzZKD9UEE7+y78
	wJC42RTg7u2Ob7ITdLip2Z2R/Cr3bHtioEX4GQDaK8lqEKGKAs//San730JA4eIPQJ458Fz
	9WXKNLX4x/ylKkMtcYBKlKmbOWp8+F75B6r/HOONWp/yQg+yaH0LZp1rc1OUD2h1QZvoinj
	HJ6u+1LZmMAC5ofT92lz7RcpEi7Z/03JQdUjRgfl2+DTw1N2YqYFarNmS11DHOBgdfSfN1q
	j9WjaLt07CHwjakDuw6bQNIWPwkwegKlWbgxrGk9WMfRHkrr1KCYUsespW7fqM5OzE8K/ys
	yaXWNOTuxMJVhZx8982zoCrUI+AVJGZ6qcl4iVPohzoL5VxWhm3YIips2hlqK9ImvuFaWEf
	NZiOYmH6bCzOqyU4FW0TbKymPmVdqSCWSosCH7Cb+60jsGE8d7lhuelExGpU/MvN60a050d
	P4fZh/YCnGlMRfNdRXgv/rXyCBDcD8Uss5FyWdHvfsNTR2v4G+ShGpyEmOYB3HarKSxnbJD
	WooJkQj73QczEIfWTxXjjwfYSxSAywkaBcpL20DC4md9l8xzAESBSSWoLBoP2QxeZwMOYYQ
	J1/SKLb849VwLXTYM3Mou9cCIr+32VoR2nclbLSVBRkvPnTxpkz+hMzc9YU0XR/WwLTChCs
	CcLXOUqshk8jQm60PKLbsbxiWHdyiuTQZ3WMmdzBX3UdwEp/t+6vBWRvTATaU3Cw9AYHDeN
	Ky3RpdX5DR9+0IFYQAA5VOmiWI3iU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

SGVsbG8sDQpUaGFua3MgZm9yIHJlcGx5Lg0KKyBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KDQpCUnMNCldlbnRhbyBHdWFu


