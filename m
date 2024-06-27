Return-Path: <stable+bounces-55943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F691A46F
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BDF1C2196A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FE513DDDF;
	Thu, 27 Jun 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g8Z+sIiT"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF31F94A;
	Thu, 27 Jun 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486048; cv=none; b=Zam6wNfOa84VTWdMBdr7X/n5E+6DG4Wv1Y/JdkUxQ8YNk6Pt1nTfRtvTWjzK3leCQDTz7Uu4mGzoX7yTxn1zXZwrgmBJseQPctXu4LdL0gvjJQ+JCxCluk5xDjS4MLI120KCCwb6kxlqAKLIOyKVzixWIuIpBNjpPUg8T+WFRmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486048; c=relaxed/simple;
	bh=GYpm+XnvHUDUSFk/UktBATcn31E8QlQ+11CQ6flQKsw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Vg7ySK+qrs2ArTGpqiJ/9SwhAbc3RK9mqOExEelYujNxU+Pv20aU8yZWNWwP0EU+6u//aTfL0XgK5uZbEYhKUyaUBdxQohYsMq+8tavpNL+zpHKnB9cwniVQq6tgmN4NCTaoO1g1IkGBAlIBGMordXkKxriP0g8QWp7PZS635oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=g8Z+sIiT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719486010; x=1720090810; i=markus.elfring@web.de;
	bh=EhLckhKVfKE7w0R51LNF24lj0PYCDE9gcP8repqcmMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g8Z+sIiToVtcL+u4dUeHcXr4JkUU+qZNfOGDu1N74BmW5VxZKH+KPwC/jiNVoJOa
	 CG3UJE1jpez6q73HN3ZzGMt7zq07MXfzugygex1hTq5DBk0cgTNhhKJf5EekIlPt2
	 zMwKaTShgPhrwbyCys3e0fpzYNtq7fzALOX6U8aZ54iXuxqpo9Fm2xJlnM8LayXpH
	 6DBnaHDZ/vMq9kgU+/M/ApBmDSO6VjzrBb36heQMN1RqxKkxoEKbXiquzfit7jbyR
	 VoJVHdCN8P9JzHoVaL8w32WLHQ29OlZ1EJnWDLOFYv82Asb7BVq/WoKaIJxux25Hq
	 ixDkjwqqDdJYTImUZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1sN3qD29Wl-00GO5I; Thu, 27
 Jun 2024 13:00:10 +0200
Message-ID: <7b5c3831-6c6f-4518-b677-6e82f0ce7ad7@web.de>
Date: Thu, 27 Jun 2024 13:00:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 Alan Cox <alan@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 David Airlie <airlied@gmail.com>
References: <20240627025033.2981966-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/gma500: fix null pointer dereference in
 psb_intel_lvds_get_modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240627025033.2981966-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Vb+Jx2vooG5cOktMPc+G7oJTsGDmB4KURcwNspnXl6og+nSjX/
 jdhxJ1IxabSWJh1A4O7biEVTEAmc4MD9ankPs5NCn8vPXfTgBIytuKoDkULFyUMQRjhikx1
 D5UryBAY27XObBXXomIbrNKMezVVy1e3ZBcjy1Ze30zxHrZFkCb8b3t3cz/TB47ZXQ7cRKG
 UPT4hyHs5cp10hNaByDew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WIWbjhk1C4A=;of0i6ck5xDlWRW/KZQCVN8MISca
 SsYH2GHpMQBKYsmZ0o661yQb/R67UoQup+VX6BOhpCjM4f9pEYyeAz7eHmv21e3wx39SnTzh2
 Z54gShKbJQMLDLrOFg0sCA2GiCYMZr68T2GYigSRQs6TKwdqSRJMZAmxtxqnXnCBsaH9v9nPg
 BnjZRaouBDi9Jw+/PjsZ/F099UUqodBCY3cM+9YXw/+5f9Cs3aoUNX/YXzerF74aDSjvUjhuZ
 g8++/SuM2r/5QVt63bduHpA6Odfgfh7xhw4hbguFkfL1yqaZlDtxBlIL/JnDWAJ2IVYtKdkXi
 AHi3RcnSDqUc1ldWzhj45UT+6gJPZ4IZhj2z72Ne8Wa8xsNkAiuZwk29i6GNugI4RpX2BWpAG
 faJhJrAYMLOAEen0RgjlzibinhcLhZng0XVrmD7Ht6rGZt1dbqoaUb0wM0TxsVGehRNfAYCLh
 yR8AB9MvemUJ5iBE9jxVI2kropgj1zl8YUt2Ne2ovaqpAZFVuQiGA5w363W+u6jfkn8CBpQMC
 nUVO0wH0TrXSF2dVaEIggAsJe82z5QUKAjUGp4muLMC/Ik2lYJzi8fXb+GBlwH/dvYTssmKUd
 rhFWr4nhoKrSwX6H32ACuAA4mptV/cIu2NHrpBwxDvOcfDkliIZ+Sjg/XjsCSJMf6qhF1s1vH
 cZku4TOeqMlNlS6ItO0tW581uUj9rfXB3ym/Qu9KfsJgMMzMlTLvmHQtu6vLv8l4knw2JgMxZ
 e0Bfc21cHyGv96VsYNx8JlZnIekmICy0ZZAlYKpILUMXp3M4v07tZODUA0InUVpT2UFMrRw3t
 vfp9wTHYasTMKyQLoe4otgP4GeooAua4CsI5Harw3He+4=

> In psb_intel_lvds_get_modes(), the return value of drm_mode_duplicate() =
is
> assigned to mode, which will lead to a possible NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.

A) Can a wording approach (like the following) be a better change descript=
ion?

   A null pointer is stored in the local variable =E2=80=9Cmode=E2=80=9D a=
fter a call
   of the function =E2=80=9Cdrm_mode_duplicate=E2=80=9D failed. This point=
er was passed to
   a subsequent call of the function =E2=80=9Cdrm_mode_probed_add=E2=80=9D=
 where an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


B) How do you think about to append parentheses to the function name
   in the summary phrase?


C) How do you think about to put similar results from static source code
   analyses into corresponding patch series?


Regards,
Markus

