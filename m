Return-Path: <stable+bounces-65222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B653A944555
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4292AB20DED
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA0157493;
	Thu,  1 Aug 2024 07:20:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F916D9DD
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496839; cv=none; b=Uj8p08nXXqRUwQ3+lwgXA5ahNmRDmtqx4KmYCSDxFEgaiP/zNhJvSrPlFNoJJOl1/exqyk6qJ9C5uSolw5DNJBZCYwa3cVaEshC55a6S7ZQu29q676QHJjZAuEtG3L6RjW99C1WQZxtoIeYHmkEvxtD51Ke8WMAVU8bIazPBwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496839; c=relaxed/simple;
	bh=l0T6dh67NWOgEHqfb5sXzUEkmtUtz3vDEjtpUsRS33U=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=rRUtelJ2si7AD0uZR8Y1S9srYinXiHGMRrP7l3L31jP+E3x8qPeevVgucdYpFQzbj0vDlwsyT5b60dAPfev/09oKipPSM3Q2e5cwHal4LcrqKkfyArHXQaVjMSVSOFtNQpW/b3YD3wmDl3k8jk7i/xsADHUoTat1MOPUgzerwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-GoodBg: 1
X-QQ-SSF: 00410000000000F0
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-XMAILINFO: NSEFX6u+4l+KyuuuOgAKM7Dz+nSWsSE0COKmfqhimrt+rfnvJw0BiuFlu+99Qa1kAAw9vGUTLfM5kw9Ts5NowEOk3dG3rSQmGZx9ObiM6OqdYuScXSYpiVZdsy+6iyf6tHByKb65nVW1LWL85L/6d50xCUmvxQKHRXJ/LLGB2M08659QbA72dM0SaiNF5CTGEFP7Ti/VT3QG7n95kAleY9jg6Cvjnby1+kPe26Ymx+FTU3m+Ug4XwHGTep0u3OspsMUx0YI2qpbtCcscDxeBrq7j5hXcnXUSnoRyaRcQxEI4CA3M96xkfEsxx6RRCkjMR9OvO8jVcPB6jxD9+Tj0SaKxYORxU/GFK+r/V+ftCe6saukzfL6WCipKXHXi82q/6kcJMdLDiTwg3rhIBvyeeaZIuyHHgD09hDoVdy/NMqh4JUVJ4WPXpUDIjwXegfxBwNSZ9F3OxoRm9lW5zESrf+XEG6cnAQqGzFKvk8VWFZ0DlWsnCjMtPuMYp2Db9E0NLJ/UxyA8AjRCiPHgOHMjVPDZAI+7rbBBDBNCqy3lqvatDk7xjbuke2MqiaNu5u2v5Go1tVwgw8+22XnADIO9UUxaK86ScZSM/62kxO1n282tqkwqYslszynMQ7ccvc1aI1JWuIzkTWuf4X/ez3x3YmyGNLKhZfv3FXRPfrvLZ6w0XJc4A+DiXtOon8+IDdh3t3ululQxri8KzXsBlgy4hKEh2hGcnAW3pChTcUuqbng26VgGOAAUrdk8p0AZKl5UicOaSVl4AezYztnN3BlE4SANzRhklAuHbb0PzyLID9rinuAO40TIIJiN/Qffr3H/ZRs1LnvBws+ZU3BEm3gKMadCEPV6RCDiIqdLj0SMUSfvHCUFrXGmOWz0sklf/hjs1BCk+7F7Wx7EH6lrViWTuVFsGHggdZJrM81Q2EgfmCXkn9wfFXSzS/cmNvOX5ExilatK0zhCBEBd08vQloqBu3
 djH0ri8gq8OTSaVv3n0UdD
X-QQ-FEAT: DTni/y8B87/LeustPHFKWBvbKe9l6iLgtIFFONKZ7zo=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: jxMyPhqGC1GjqAvPmU49Q9lD2aEfLH3WSVEDbyZtU5E=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1722496825t7634427
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?utf-8?B?amFjaw==?=" <jack@suse.cz>, "=?utf-8?B?dHl0c28=?=" <tytso@mit.edu>, "=?utf-8?B?YWRpbGdlci5rZXJuZWw=?=" <adilger.kernel@dilger.ca>, "=?utf-8?B?bGludXgtZXh0NA==?=" <linux-ext4@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?eXVrdWFpMw==?=" <yukuai3@huawei.com>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?5byg5Li55Li5?=" <zhangdandan@uniontech.com>, "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>
Subject: Re:[PATCH 3/4] ext4: factor out write end code of inline file
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 1 Aug 2024 15:20:24 +0800
X-Priority: 3
Message-ID: <tencent_1FBD8EA904994A89450D0173@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240720155234.573790-1-wangyuli@uniontech.com>
	<4FE3D7C60FFE378C+20240720155234.573790-4-wangyuli@uniontech.com>
In-Reply-To: <4FE3D7C60FFE378C+20240720155234.573790-4-wangyuli@uniontech.com>
X-QQ-ReplyHash: 459289878
X-BIZMAIL-ID: 10892746479139511733
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 01 Aug 2024 15:20:26 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

SGVsbG8gWXVsaToNCg0KSSB0aGluayB0aGF0ICIodm9pZCkgZXh0NF9maW5kX2lubGluZV9k
YXRhX25vbG9jayhpbm9kZSk7IiBzaG91bGQgYmVmb3JlIA0KZXh0NF93cml0ZV9pbmxpbmVf
ZGF0YShpbm9kZSwgJmlsb2MsIGthZGRyLCBwb3MsIGNvcGllZCk7DQpPciAgdGhlIGJhY2tw
b3J0IGNhdXNlIGEgcmVncmVzc2lvbiBvZiBjb21taXQgYzQ4MTYwN2JhDQooImV4dDQ6IGZp
eCByYWNlIHdyaXRpbmcgdG8gYW4gaW5saW5lX2RhdGEgZmlsZSB3aGlsZSBpdHMgeGF0dHJz
IGFyZSBjaGFuZ2luZyIpDQoNCkxpbms6aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjEwODIxMDM1NDI3LjE0NzE4NTEtMS10eXRzb0BtaXQuZWR1Lw0KDQpCUnMNCldlbnRhbyBH
dWFu


