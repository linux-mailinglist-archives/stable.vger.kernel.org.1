Return-Path: <stable+bounces-166797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73435B1DC99
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 19:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1639582D5C
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D55273D80;
	Thu,  7 Aug 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Wj+po/Bh"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D625B2FA;
	Thu,  7 Aug 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588680; cv=none; b=PpRqcRugoCcY0Nzpa448uF1yzezwn/6B8+KtZ9Ez2eIpV9r/V0w8Y/o9BfOku32siB2nV059cx1XXLQYm6ehLwyYvDkYYymsH88wm8LOGaP4ILGlZLOslEd+hAnIDOHQvE+n5GgCezNCHtouKDs1/oq2LajFpPf7CQP6jSMo+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588680; c=relaxed/simple;
	bh=S1QZjuhVpwv3KYWPm8Fi9kdkQj/q/2U1/cDy6IH0b7Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=g5h+Aom6CYuBHuGmPjOHp/96n3qk9Dj1K5xkuYZCnNDDZ9ibjw95was2YIwVBvPA4Qi+xvynrWzby8P8eKW0k7oY+LvrPSP53TWGaLjshfwOQ7I2ld5iIQr1sp/mtzUtWlIdgItJXdWjuM0iToUn/A0RLZLYKGuJmWcZBOyZpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Wj+po/Bh; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4byZKs1rt7z9shw;
	Thu,  7 Aug 2025 19:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1754588673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+438XYLoGKPC0jROIgVas6tBKICrKaix6D4/2BPOe0=;
	b=Wj+po/BhakOc5O87beddYp4o7i9ekUSLHxYCXccrStZoTX0KyH3mFoF9klbiN7/SJ0djlP
	SNeUqRI1YfcTlshp9cbvlC6lW+WrMSyXxTBUBu58nm12DQ4A3t1XVKqFd1+nVuUPVeliGX
	TkCA7MSkauU/Xw1ZCM53lNglGB3qdsmNTDn3XVkAOVEofek6JMDEf1efa3CTmRgWReBAXr
	bGaTxj257CRuLHN1EL052I+bz4mVhLNpjAFui30HRJknhP+HVqoSc02Sv0mWpVxdqjeicV
	AehlUfrCMvf49cOmJKfJVApSlkW4thn+WFZ/HFONz71MRHl2fg/JIWqqYepVlw==
Message-ID: <87960e35-5b7b-4b7e-9bba-50db6292cd5b@hauke-m.de>
Date: Thu, 7 Aug 2025 19:44:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: Lion Ackermann <nnamrec@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 netdev@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: stable 5.15 backport: sch_*: make *_qlen_notify() idempotent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Kernel 5.15.189 is showing a warning caused by:
commit e269f29e9395527bc00c213c6b15da04ebb35070
Author: Lion Ackermann <nnamrec@gmail.com>
Date:   Mon Jun 30 15:27:30 2025 +0200
      net/sched: Always pass notifications when child class becomes empty
      [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]

See here for details: https://www.spinics.net/lists/netdev/msg1113109.html

To fix this please backport the following 4 commits to 5.15 stable:

commit 5ba8b837b522d7051ef81bacf3d95383ff8edce5
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Apr 3 14:10:23 2025 -0700

     sch_htb: make htb_qlen_notify() idempotent


commit df008598b3a00be02a8051fde89ca0fbc416bd55
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Apr 3 14:10:24 2025 -0700

     sch_drr: make drr_qlen_notify() idempotent


commit 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Apr 3 14:10:25 2025 -0700

     sch_hfsc: make hfsc_qlen_notify() idempotent


commit 55f9eca4bfe30a15d8656f915922e8c98b7f0728
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu Apr 3 14:10:26 2025 -0700

     sch_qfq: make qfq_qlen_notify() idempotent


Kernel 6.1 stable already contains them. Kernel 5.10 stable does not 
contain the patch which causes problems.

Hauke

