Return-Path: <stable+bounces-89769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC69BC1ED
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 01:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2080D2828C0
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 00:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE417583;
	Tue,  5 Nov 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gEYmdjLI"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED5D530
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766088; cv=none; b=TnLc2fthsq2nVTKFFMST4DGtu2hUHSZVTeMf3D1VoVmJ7sQLm4F8/NDTdt7HiCAxS7lB8+F2Shzg8AxsgP9RiVPzMxRW8ZuG/BG9RZnG/p/O5POadvo1MknUol/K+VEmaKu929nD3YxvmP8CFMFutfFEx4tNyrEUK9OdzizIE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766088; c=relaxed/simple;
	bh=mQDBnoxyXVmxCL49/5xTQ6KX5/j3OIz2ojb+auRUu10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7a/lMVa8pMy1LB9QiGz+w6myjf4WQkB+hkjnIVkPw5vdtZQMn3Y3mnqnUGZ5EslHQik+3o4LaZhzjsCuHzi6y4nrSsk00JDCkSy8hns8+o/rTqksnsJvMd+kqsdTDMlXdT3WkffdY3rY2NL7fveQLiR+8pEVrtv6wS9BeOEKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gEYmdjLI; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730766087;
	bh=rm5lLoi3XUYT4KuUUvHO+moVuXskhwLUpd2Qbpm2GUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=gEYmdjLIhOf2sSMdvcEL+e3kBlfkLqGZ/ms3ZzYwRkQA9yQdaFN+Pp2a0vVzCZ5F9
	 Ls1drPwsXFUINVzHMIzy7K5vrZy3EsO0MV8WXHO+5Nm+FajXZEXJKuOtBeW/YL2sLm
	 8gWfjCYOUb2QsOKzEKrTCUfUo8fY6+MvVYygNW05tD2KtiW0BMv90D3bmrp54Zv4JK
	 UOMN8k4N72Ir/jEYwy337k6ipOX58OYOWTSSVceIW7hIFodwDYq966j7//iD1IRe78
	 0Bi3qMicCaFgurtrXS6h7du+MJCD+ue5CfrOed+e57u3qN0eU8+7D37g829QKd9xsr
	 dgnvAEevl709Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id A0445D0027F;
	Tue,  5 Nov 2024 00:21:23 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 05 Nov 2024 08:20:22 +0800
Subject: [PATCH 1/3] driver core: class: Fix wild pointer dereference in
 API class_dev_iter_next()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-class_fix-v1-1-80866f9994a5@quicinc.com>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
In-Reply-To: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
has return type void, but it does not initialize its output parameter @iter
when suffers class_to_subsys(@class) error, so caller can not detect the
error and call API class_dev_iter_next(@iter) which will dereference wild
pointers of @iter's members as shown by below typical usage:

// @iter's members are wild pointers
struct class_dev_iter iter;

// No change in @iter when the error happens.
class_dev_iter_init(&iter, ...);

// dereference these wild member pointers here.
while (dev = class_dev_iter_next(&iter)) { ... }.

Actually, all callers of the API have such usage pattern in kernel tree.
Fix by memset() @iter in API *_init() and error checking @iter in *_next().

Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
Alternative fix solutions ever thought about:

1) Use BUG_ON(!sp) instead of error return in class_dev_iter_init().
2) Change class_dev_iter_init()'s type to int, lots of jobs to do.
---
 drivers/base/class.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index cb5359235c70..b331dda002e3 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -323,8 +323,11 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 	struct subsys_private *sp = class_to_subsys(class);
 	struct klist_node *start_knode = NULL;
 
-	if (!sp)
+	memset(iter, 0, sizeof(*iter));
+	if (!sp) {
+		pr_crit("%s: the class was not registered yet\n", __func__);
 		return;
+	}
 
 	if (start)
 		start_knode = &start->p->knode_class;
@@ -351,6 +354,9 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
 	struct klist_node *knode;
 	struct device *dev;
 
+	if (!iter->sp)
+		return NULL;
+
 	while (1) {
 		knode = klist_next(&iter->ki);
 		if (!knode)

-- 
2.34.1


