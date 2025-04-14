Return-Path: <stable+bounces-132442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B505FA87F7E
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B79173EFA
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08E2980BA;
	Mon, 14 Apr 2025 11:44:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F172853EB
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631092; cv=none; b=Fjh5keM6rOS71QLV230u4ssyS0/Qqs+unItXM3S9Ow4Bd5i7JnIjuiz8+rGbTjuOpDl5VOn8L4+1z3BXLUbqHeV/KpKBHOQX/EGWHunlfJLrnLl+MBrYET2Uywb9evBLDVIKVmD/yVgzR91ZSg4Y4OumGSIP77GS3oNqFpQZOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631092; c=relaxed/simple;
	bh=eNSaHlvEIP2M+Wl70rGcLoYlRcf6km68wl9xNSOkjlk=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:CC:From:Subject; b=tBu3+uGZPSI3fYL0/RxSxMTrZPXtAP3R0+Lx86EZsJ+pXjBzqov9CwfYyGJqYhV27r6bke7vFbcaNRpWYcOwt5BOb+o1iZVgN48Zd3b3jI4h8rCA24/XAW/L5ZP3oqVUUg9SmgkstwoJ75KqTsuXEqC0qLKZGOw46QBaX6laOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zbljs1pCdz2CdYG;
	Mon, 14 Apr 2025 19:41:21 +0800 (CST)
Received: from kwepemg100004.china.huawei.com (unknown [7.202.181.21])
	by mail.maildlp.com (Postfix) with ESMTPS id A611C1800B2;
	Mon, 14 Apr 2025 19:44:46 +0800 (CST)
Received: from [10.67.111.137] (10.67.111.137) by
 kwepemg100004.china.huawei.com (7.202.181.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 19:44:46 +0800
Content-Type: multipart/mixed;
	boundary="------------z6kcUXTqDTHc4C349fgCGwX0"
Message-ID: <42fa27ef-1807-4fd0-aaf0-1a1ceb1db10e@huawei.com>
Date: Mon, 14 Apr 2025 19:44:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <stable@vger.kernel.org>
CC: <regressions@lists.linux.dev>
From: "liaochen (A)" <liaochen4@huawei.com>
Subject: BUG: perf hardware breakpoint pc value mismatch
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100004.china.huawei.com (7.202.181.21)

--------------z6kcUXTqDTHc4C349fgCGwX0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


Hi all,

We found the following issue with Linux v6.12-rc7 on KunPeng920 
platform. A very low frequency problem of pc value mismatch occurs when 
using perf hardware breakpoints to trigger a signal handler and 
comparing pc from u_context with its desired value.

Attached please find the reproducer for this issue. It applies perf 
events to set a hardware breakpoint to an address while binding a signal 
to the perf event fd. When stepping into the breakpoint address, the 
signal handler compares pc value copied from signal ucontext with the 
real breakpoint address and see if there is a mismatch.

While looking into the flow of execution:
// normal flow of exe:
            a.out-19844   [038] d...  8763.348609: 
hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 0
// breakpoint exception:
            a.out-19844   [038] d...  8763.348611: do_debug_exception: 
ec: 0, pc: 400c6c, pstate: 20001000
            a.out-19844   [038] d...  8763.348611: breakpoint_handler: 
perf bp read: 400c6c
// send signal:
            a.out-19844   [038] d.h.  8763.348613: send_sigio_to_task 
<-send_sigio
            a.out-19844   [038] d.h.  8763.348614: <stack trace>
  => send_sigio_to_task
  => send_sigio
  => kill_fasync_rcu
  => kill_fasync
  => perf_event_wakeup
  => perf_pending_event
  => irq_work_single
  => irq_work_run_list
  => irq_work_run
  => do_handle_IPI
  => ipi_handler
  => handle_percpu_devid_fasteoi_ipi
  => __handle_domain_irq
  => gic_handle_irq
  => el0_irq_naked
            a.out-19844   [038] d.h.  8763.348614: send_sigio_to_task: 
step in with signum 38
            a.out-19844   [038] d.h.  8763.348615: send_sigio_to_task: 
will do_send_sig_info 38
// kernel signal handling:
            a.out-19844   [038] ....  8763.348616: do_notify_resume: 
thread_flags 2097665, _TIF_SIGPENDING 1, _TIF_NOTIFY_SIGNAL40
            a.out-19844   [038] ....  8763.348617: setup_sigframe: 
restore sig: 400c6c
// single step exception:
            a.out-19844   [038] d...  8763.348619: do_debug_exception: 
ec: 1, pc: 400988, pstate: 20001000
            a.out-19844   [038] d...  8763.348621: 
hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 1

// abnormal flow of exe:
            a.out-19844   [084] d...  8763.782103: 
hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 0
// breakpoint exception:
            a.out-19844   [084] d...  8763.782104: do_debug_exception: 
ec: 0, pc: 400c6c, pstate: 20001000
// single step exception:
            a.out-19844   [084] d...  8763.782105: breakpoint_handler: 
perf bp read: 400c6c
            a.out-19844   [084] d...  8763.782107: do_debug_exception: 
ec: 1, pc: 400c70, pstate: 20001000
// send signal:
            a.out-19844   [084] d.h.  8763.782108: send_sigio_to_task 
<-send_sigio
            a.out-19844   [084] d.h.  8763.782109: <stack trace>
  => send_sigio_to_task
  => send_sigio
  => kill_fasync_rcu
  => kill_fasync
  => perf_event_wakeup
  => perf_pending_event
  => irq_work_single
  => irq_work_run_list
  => irq_work_run
  => do_handle_IPI
  => ipi_handler
  => handle_percpu_devid_fasteoi_ipi
  => __handle_domain_irq
  => gic_handle_irq
  => el0_irq_naked
            a.out-19844   [084] d.h.  8763.782110: send_sigio_to_task: 
step in with signum 38
            a.out-19844   [084] d.h.  8763.782110: send_sigio_to_task: 
will do_send_sig_info 38
// kernel signal handling:
            a.out-19844   [084] ....  8763.782111: do_notify_resume: 
thread_flags 513, _TIF_SIGPENDING 1, _TIF_NOTIFY_SIGNAL40
            a.out-19844   [084] ....  8763.782113: setup_sigframe: 
restore sig: 400c70
            a.out-19844   [084] d...  8763.782115: 
hw_breakpoint_control: perf user addr: 400c6c, bp addr: 400c6c, ops: 1

Kernel sends this signal to task through pushing a perf_pending_event 
(which sends the signal) in irq_work_queue then triggering an IPI to let 
kernel handle this pended task.
seems that when mismatch occurs, the IPI does not preempt the breakpoint 
exception it should preempt, causing no pending signals to be handled. 
In this way, there is no pending signals in do_notify_resume and kernel 
will not set up signal frame with correct pc value.

Thanks,
Chen
--------------z6kcUXTqDTHc4C349fgCGwX0
Content-Type: text/plain; charset="UTF-8"; name="reproducer.cpp"
Content-Disposition: attachment; filename="reproducer.cpp"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmlu
Zy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUg
PHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxsaW51eC9wZXJmX2V2ZW50Lmg+CiNpbmNsdWRl
IDxzdGRpbnQuaD4KI2luY2x1ZGUgPHVjb250ZXh0Lmg+CiNpbmNsdWRlIDxsaW51eC9od19i
cmVha3BvaW50Lmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9mY250
bC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRl
IDx0aHJlYWQ+Cgp1c2luZyBuYW1lc3BhY2Ugc3RkOwoKc3RhdGljIHZvaWQgKmJyZWFrcG9p
bnRfYWRkciA9IE5VTEw7Cgp2b2lkIHNpZ25hbF9oYW5kbGVyKGludCBzaWdudW0sIHNpZ2lu
Zm9fdCAqaW5mbywgdm9pZCAqY29udGV4dCkgewogICAgaW9jdGwoaW5mby0+c2lfZmQsIFBF
UkZfRVZFTlRfSU9DX0RJU0FCTEUsIDApOwogICAgY2xvc2UoaW5mby0+c2lfZmQpOwogICAg
dWNvbnRleHRfdCAqdWNvbnRleHQgPSAodWNvbnRleHRfdCAqKWNvbnRleHQ7CiAgICB1aW50
cHRyX3QgcGMgPSAodWludHB0cl90KXVjb250ZXh0LT51Y19tY29udGV4dC5wYzsKCiAgICBp
ZiAocGMgIT0gKHVpbnRwdHJfdClicmVha3BvaW50X2FkZHIpCiAgICAgICAgcHJpbnRmKCJX
YXJuaW5nOiBQQyAoMHglbHgpIGRvZXMgbm90IG1hdGNoIGJyZWFrcG9pbnQgYWRkcmVzcyAo
MHglbHgpIHNpZ251bTogJWRcbiIsIHBjLCAodWludHB0cl90KWJyZWFrcG9pbnRfYWRkciwg
c2lnbnVtKTsKfQoKc3RhdGljIGludCBzZXRfaHdfYnJlYWtwb2ludCh2b2lkICphZGRyKSB7
CiAgICBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyIHBlOwogICAgaW50IGZkOwoKICAgIG1lbXNl
dCgmcGUsIDAsIHNpemVvZihzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyKSk7CiAgICBwZS50eXBl
ID0gUEVSRl9UWVBFX0JSRUFLUE9JTlQ7CiAgICBwZS5zaXplID0gc2l6ZW9mKHN0cnVjdCBw
ZXJmX2V2ZW50X2F0dHIpOwogICAgcGUuY29uZmlnID0gMDsKICAgIHBlLmJwX3R5cGUgPSBI
V19CUkVBS1BPSU5UX1g7CiAgICBwZS5icF9hZGRyID0gKHVpbnRwdHJfdClhZGRyOwogICAg
cGUuYnBfbGVuID0gNDsKICAgIHBlLnNhbXBsZV9wZXJpb2QgPSAxOwogICAgcGUuZGlzYWJs
ZWQgPSAxOwogICAgcGUuZXhjbHVkZV9rZXJuZWwgPSAxOwoKICAgIC8vIHBlcmZfZXZlbnRf
b3BlbiBzeXNjYWxsCiAgICBmZCA9IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50X29wZW4sICZw
ZSwgc3lzY2FsbChTWVNfZ2V0dGlkKSwgLTEsIC0xLCAwKTsKICAgIGlmIChmZCA8IDApIHsK
ICAgICAgICBwZXJyb3IoInBlcmZfZXZlbnRfb3BlbiIpOwogICAgICAgIHJldHVybiAtMTsK
ICAgIH0KCiAgICBzdHJ1Y3QgZl9vd25lcl9leCBvd25lcjsKICAgIG93bmVyLnR5cGUgPSBG
X09XTkVSX1RJRDsKICAgIG93bmVyLnBpZCA9IHN5c2NhbGwoU1lTX2dldHRpZCk7CgogICAg
aWYgKGZjbnRsKGZkLCBGX1NFVE9XTl9FWCwgJm93bmVyKSA9PSAtMSkKICAgIHsKICAgICAg
ICBwZXJyb3IoIkZfU0VUU0lHIik7CiAgICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICAg
fQoKICAgIGlmIChmY250bChmZCwgRl9TRVRTSUcsIFNJR1JUTUlOKzQpID09IC0xKSB7CiAg
ICAgICAgcGVycm9yKCJGX1NFVFNJRyIpOwogICAgICAgIGNsb3NlKGZkKTsKICAgICAgICBl
eGl0KEVYSVRfRkFJTFVSRSk7CiAgICB9CgogICAgaW50IGZsYWdzID0gZmNudGwoZmQsIEZf
R0VURkwsIDApOwogICAgaWYgKGZsYWdzID09IC0xKSB7CiAgICAgICAgcGVycm9yKCJGX0dF
VEZMIik7CiAgICAgICAgY2xvc2UoZmQpOwogICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsK
ICAgIH0KCiAgICBpZiAoZmNudGwoZmQsIEZfU0VURkwsIGZsYWdzIHwgT19BU1lOQykgPT0g
LTEpIHsKICAgICAgICBwZXJyb3IoIkZfU0VURkwiKTsKICAgICAgICBjbG9zZShmZCk7CiAg
ICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICAgfQoKICAgIC8vIGVuYWJsZSBicmVha3Bv
aW50CiAgICBpZiAoaW9jdGwoZmQsIFBFUkZfRVZFTlRfSU9DX1JFU0VULCAwKSA8IDApIHsK
ICAgICAgICBwZXJyb3IoIlBFUkZfRVZFTlRfSU9DX1JFU0VUIik7CiAgICAgICAgY2xvc2Uo
ZmQpOwogICAgICAgIHJldHVybiAtMTsKICAgIH0KCiAgICBpZiAoaW9jdGwoZmQsIFBFUkZf
RVZFTlRfSU9DX0VOQUJMRSwgMCkgPCAwKSB7CiAgICAgICAgcGVycm9yKCJQRVJGX0VWRU5U
X0lPQ19FTkFCTEUiKTsKICAgICAgICBjbG9zZShmZCk7CiAgICAgICAgcmV0dXJuIC0xOwog
ICAgfQoKICAgIHJldHVybiBmZDsKfQoKLy8gZnVuY3Rpb24gd2hlcmUgYnJlYWtwb2ludHMg
Z2V0IHNldAp2b2lkIHRhcmdldF9mdW5jdGlvbigpIHsKICAgIGludCBpID0gMDsKICAgIGkr
KzsKfQoKaW50IG1haW4oKSB7CiAgICBpbnQgYnJlYWtwb2ludF9mZDsKCiAgICAvLyBzZXQg
YnJlYWtwb2ludAogICAgYnJlYWtwb2ludF9hZGRyID0gKHZvaWQgKil0YXJnZXRfZnVuY3Rp
b247CiAgICBwcmludGYoIkJyZWFrcG9pbnQgYWRkcmVzczogJXAsIHRhcmdldF9mdW5jdGlv
biBhZGRyZXNzOiAlcFxuIiwgYnJlYWtwb2ludF9hZGRyLCB0YXJnZXRfZnVuY3Rpb24pOwoK
ICAgIC8vIHNldCBzaWcgaGFuZGxlcgogICAgc3RydWN0IHNpZ2FjdGlvbiBzYTsKICAgIG1l
bXNldCgmc2EsIDAsIHNpemVvZihzdHJ1Y3Qgc2lnYWN0aW9uKSk7CiAgICBzYS5zYV9zaWdh
Y3Rpb24gPSBzaWduYWxfaGFuZGxlcjsKICAgIHNhLnNhX2ZsYWdzID0gU0FfU0lHSU5GTyB8
IFNBX1JFU1RBUlQ7CiAgICBzaWdmaWxsc2V0KCZzYS5zYV9tYXNrKTsKICAgIGlmIChzaWdh
Y3Rpb24oU0lHUlRNSU4rNCwgJnNhLCBOVUxMKSA9PSAtMSkgewogICAgICAgIHBlcnJvcigi
c2lnYWN0aW9uIik7CiAgICAgICAgY2xvc2UoYnJlYWtwb2ludF9mZCk7CiAgICAgICAgcmV0
dXJuIEVYSVRfRkFJTFVSRTsKICAgIH0KCiAgICAvLyB0ZXN0IGJyZWFrcG9pbnQKICAgIHBy
aW50ZigiQ2FsbGluZyB0YXJnZXQgZnVuY3Rpb24uLi5cbiIpOwogICAgd2hpbGUgKDEpIHsg
ICAgCglicmVha3BvaW50X2ZkID0gc2V0X2h3X2JyZWFrcG9pbnQoYnJlYWtwb2ludF9hZGRy
KTsKICAgICAgICBpZiAoYnJlYWtwb2ludF9mZCA8IDApIHsKICAgICAgICAgICAgZnByaW50
ZihzdGRlcnIsICJGYWlsZWQgdG8gc2V0IGhhcmR3YXJlIGJyZWFrcG9pbnRcbiIpOwogICAg
ICAgICAgICByZXR1cm4gMTsKICAgICAgICB9CiAgICAgICAgICAgIHRhcmdldF9mdW5jdGlv
bigpOwoJLy8gZGlzYWJsZSBicmVha3BvaW50CiAgICAJaW9jdGwoYnJlYWtwb2ludF9mZCwg
UEVSRl9FVkVOVF9JT0NfRElTQUJMRSwgMCk7CiAgICAJY2xvc2UoYnJlYWtwb2ludF9mZCk7
CiAgICB9CgogICAgcmV0dXJuIDA7Cn0KCg==

--------------z6kcUXTqDTHc4C349fgCGwX0--

