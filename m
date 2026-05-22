Return-Path: <stable+bounces-253801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NvbIutmEGoKXAYAu9opvQ
	(envelope-from <stable+bounces-253801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DD15B612C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674FE30128CF
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07E4028D3;
	Fri, 22 May 2026 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJerQdq3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856813D5240
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459391; cv=pass; b=em8mD9seGeq8hjxXHdq4arDlPgRNFrv0d9GKUhU0XSdOJsIx+gbHkudvEtt6HuSQq5a7LRLA7hpkKy0Rs4MMYiSsVtTqCYO68HJyAelOhcGiPdYeZ7PtdPUqZLOd9AwbaTfWxfPlbvDipV37GfNcxv07G+wZTXdmOcnZdkcq2Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459391; c=relaxed/simple;
	bh=B3EEr0gqgVtm2Kof6fjO8Fpy73P57jRMLQjJuPBbvBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFddqQl1UiMfbTMIHOMvMqEB4LHX3s8EC/MVI0bISKU7RJuMah7RRjS14dc4SRp2vixF4mtaOx9KY4Bjq5xybJvj1TmaymeGvg5fLlX62aKCx8cV00vzlmIbocKegQZWYMD0BpdFGwLAY6Zy7ks4TgNx4jpPkhGKlEYfgUUNHM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJerQdq3; arc=pass smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so7802802e87.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 07:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779459380; cv=none;
        d=google.com; s=arc-20240605;
        b=HcNaSwVAfwUC8GeV/+2J5+CGFetmEspOUkGVYw7IZKiFNMM7YsAa+Iv/hqvWUnGsVx
         qAO+Y8f4yzYX9JRWUrCTSZELZdxHIfoku+/C+06VoKr79x9VaW15aCegB9Jyi4+UexH9
         V4zhHm6Ld29RKPwd+uW8Nucpu920Vx9fDzOa9Lpkgo03/y77YAUW07Bw/xmkD8tnbNw4
         f2JsG1Mz2HrlLqxAN9uLG4jS72JoQs227xeZNmAQ5yI98DJ/sXZelbT6+5xxjLutDOhC
         6UuoofTN5zgaSRHVhThr+n6VsfkmywZN4gAGmnqdAmne9E9Jy+qjXyBLK42WRIBCYM59
         T3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+n6Yirf0v1P3HfP/29lw8BxGZOk0s1Y9CPnglZ2k48=;
        fh=J9Iqs5ySvZWQE7lI/WSk/TIHpGKexYyT69jSYVjt3f0=;
        b=AbYHgXgW8QS+C9rHGVcUz4Vu7JX0SixarKk0BUQ5Qag302RjTqIuO9B0DCbqN5iOEo
         cHDj4vpy3JnWiUANq50vEQ4qTzGMBpNvT5pjVeeJwrd3Bogl8rmco4zOJBXRYVombK8V
         1+LmVNoVTkIhAkOtdfANK5Omkl/LQhpgd99SItUzlfcBTOVNMW2y7ZoAPk1JQrXCQ73x
         nedPVaydNhn8Rz0a6vNmkpKgUsFIyorDEMBZcmeJ5SSBLcinCvpA0ZkfSZ0OS1m7mIac
         50AN7YrDTTKdNGbse+PTiCJrEV6Sj1qdpQaHzEBSrwf5N0rlAD5WUOG3zkox2cZSKaMP
         BNZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459380; x=1780064180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+n6Yirf0v1P3HfP/29lw8BxGZOk0s1Y9CPnglZ2k48=;
        b=hJerQdq3kB3JK3peb4+al0tYpI9aINllB2VwEJVkuW6uXR73zYjb3IIw5Ds8RQGSxP
         0c9O6Pkjtg5wtoMWbYRhx7loThlhr5IXqPMhK3gnrljO/u3MhqlA5PEvHzOq0+irymT5
         apSpg1wte+KrEg+EzEB0q6weJa8C+cVBX+8GEqv6MFr4B0lQ0j2lOh4bgbSFVw4/eoMo
         abJmO/euithNiWrWjpYiWAdqcr9qMtPm9GyUCuq9laykAA+xQx9UZobAuJ/J001MQdBc
         81DvaIMAX437hhTywsZKWBL3Fm2Fq4hbMtI7LVcgHuUrEA79/RiIl2AtE0lhCBFOTSIu
         sBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459380; x=1780064180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+n6Yirf0v1P3HfP/29lw8BxGZOk0s1Y9CPnglZ2k48=;
        b=TtHZPJwfu8oHC8zP4j/B6zo/mFbkMmKlIS1bZfh9lWyJUd88FsFvPMfzUrNhcW2MYW
         hU0+LQjjbLmwiCbbgD+t22LvhSMCwSzzGjSkqXkcXw2CwWlsyFCTGxluryT+iJTjL9oa
         WYGtBJBiduHu2E9koD2PJAusuFhgvpW0l8vyN1tHieW/d5h49FVK28m2Kr5rAnSxSD3m
         gcGED0NdtfzLOlWz8ED1M+TA4TmXH6a3A5jC7vBP102OB7EbG1XSQZaBlOkFVJfcCC7u
         zZzFqREw9x/4jyKzWT7LRsT3WtK6+4UqmoCHprygPkFbdjOPh+EaDExo+rdXDhafqUso
         YA4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/824N3Apr/nSskhyiNGQ+uaWvPdNdJGAGBONsowVeWofMY4kf9PMBfDompIWJW1h1BMHARauQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2h+Sd+u6riXlx+1LF+tWrhIrpH2U6pdtU7HlbJictq1cTPo6
	wm+3inTkXb8hMzAjttUYWd74UHp4eB0fZ8wmt0DxM+LOMUtEOoYo9gRN2g8XAiZGeQVwIEOIhfV
	rNwLMw/RZ4IB+d2gf9+nSfQl/LzTeFXM=
X-Gm-Gg: Acq92OFmDUyJXBICBy5OIarCF2yLheW6VTa8fV6rr7QLWPKSrUCRl9adR8wP8lCO9EN
	zHDstG2HPK0tLRKWmhtXWkSPGkF+eM7HWLrKMy3sFQmbtWDBJHJ6YE5/d7NIyPfq8zN/H09Wfbt
	F3S+gZOkJFCYMQxQpqV2/sH566ST8sQCMFZnRuJBw18x1bcP/2AS8Wu1CjDeGCUXy+g8jm5pxFU
	MDBnFzd6GYf226oSFIl7D8XIFUt4oGvlPDAcpIDiTpBCa1/Kn14qpBB2mTk1F3M8hdjHLTWsRNi
	HQUr1ZxA438PPOGcvatIkJP3fqR3LS4=
X-Received: by 2002:a05:6512:114e:b0:5a8:7eda:7d8f with SMTP id
 2adb3069b0e04-5aa2ba85a0cmr2795757e87.12.1779459379767; Fri, 22 May 2026
 07:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522101621.927034-1-johan@kernel.org>
In-Reply-To: <20260522101621.927034-1-johan@kernel.org>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Fri, 22 May 2026 22:16:07 +0800
X-Gm-Features: AVHnY4LLi_UAUu4628kPIHkP3hsXAHdT0JF_Wlaw-QcDWkoP4pZscepPbX-GZA0
Message-ID: <CAB7XQsFYZcNssaxjYYoBm4ROgFAAYHYOKXWzFs2YK4cLiYF0Qg@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: cypress_m8: fix memory corruption with small endpoint
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253801-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: F2DD15B612C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johan,

I took a closer look at your patch and tested it on top of commit
917719c412c4 with KASAN enabled.  I applied your patch, rebuilt the
kernel, and reran the same reproducer I used for the report.

The original reproducer still triggers:

  BUG: KASAN: slab-out-of-bounds in cypress_read_int_callback+0x240/0x7f0
  Read of size 1

I reproduced this with the in-kernel dummy_hcd host and the raw_gadget
interface. The emulated Earthmate-compatible device uses:

idVendor =3D 0x1163
idProduct =3D 0x0200
interrupt-in ep =3D 0x81, wMaxPacketSize =3D 1
interrupt-out ep =3D 0x02, wMaxPacketSize =3D 16

To reproduce, boot a KASAN kernel with dummy_hcd, raw_gadget,
usbserial, and cypress_m8 enabled, then run:

  modprobe -r g_zero g_serial g_mass_storage 2>/dev/null || true
  modprobe dummy_hcd raw_gadget usbmon usbserial cypress_m8 || true
  gcc -Wall -Wextra -O2 -o cypress_minigadget cypress_minigadget.c
  ./cypress_minigadget &
  for i in $(seq 1 160); do
          [ -e /dev/ttyUSB0 ] && break
          sleep 0.25
  done
  sh -c 'exec 3<>/dev/ttyUSB0; sleep 6; exec 3>&-'

The full reproducer is included below.

I think the reason is that your patch rejects small interrupt-out
endpoint sizes, but this reproducer has interrupt_out_size =3D 16, so the
new check is not hit.  The remaining issue is on the read side:
packet_format_1 reads data[1] before checking that urb->actual_length
contains the two-byte header.

I also tested a variant with interrupt-out wMaxPacketSize =3D 1.  Your
patch rejects that device during port probe with -EINVAL before ttyUSB0
is exposed, so the new check works for that endpoint-size case.

Please let me know if I missed anything in the test setup or in the
analysis above.  I am happy to help test another version, or send a
follow-up patch for cypress_read_int_callback() using your earlier
comments if that would be useful.

Best regards,
Zhang Cen

---- reproducer: cypress_minigadget.c ----
#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include <linux/types.h>
#include <linux/usb/ch9.h>

/*
 * Minimal Raw Gadget UAPI copied into this standalone harness so the guest
 * can compile it without depending on a matching linux-libc-dev package.
 */
#define UDC_NAME_LENGTH_MAX 128
#define USB_RAW_EPS_NUM_MAX 30
#define USB_RAW_EP_NAME_MAX 16
#define USB_RAW_EP_ADDR_ANY 0xff

struct usb_raw_init {
__u8 driver_name[UDC_NAME_LENGTH_MAX];
__u8 device_name[UDC_NAME_LENGTH_MAX];
__u8 speed;
};

enum usb_raw_event_type {
USB_RAW_EVENT_INVALID =3D 0,
USB_RAW_EVENT_CONNECT =3D 1,
USB_RAW_EVENT_CONTROL =3D 2,
USB_RAW_EVENT_SUSPEND =3D 3,
USB_RAW_EVENT_RESUME =3D 4,
USB_RAW_EVENT_RESET =3D 5,
USB_RAW_EVENT_DISCONNECT =3D 6,
};

struct usb_raw_event {
__u32 type;
__u32 length;
__u8 data[];
};

struct usb_raw_ep_io {
__u16 ep;
__u16 flags;
__u32 length;
__u8 data[];
};

struct usb_raw_ep_caps {
__u32 type_control : 1;
__u32 type_iso : 1;
__u32 type_bulk : 1;
__u32 type_int : 1;
__u32 dir_in : 1;
__u32 dir_out : 1;
};

struct usb_raw_ep_limits {
__u16 maxpacket_limit;
__u16 max_streams;
__u32 reserved;
};

struct usb_raw_ep_info {
__u8 name[USB_RAW_EP_NAME_MAX];
__u32 addr;
struct usb_raw_ep_caps caps;
struct usb_raw_ep_limits limits;
};

struct usb_raw_eps_info {
struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor=
)
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)

#define VENDOR_ID 0x1163
#define PRODUCT_ID 0x0200
#define CONFIG_VALUE 1
#define IN_MAX_PACKET 1
#define OUT_MAX_PACKET 16
#define SET_REPORT 0x09
#define GET_REPORT 0x01

struct descriptor_block {
struct usb_config_descriptor config;
struct usb_interface_descriptor intf;
struct usb_endpoint_descriptor ep_in;
struct usb_endpoint_descriptor ep_out;
} __attribute__((packed));

static int raw_fd =3D -1;
static int ep_in_handle =3D -1;
static int ep_out_handle =3D -1;
static uint8_t ep_in_addr =3D 0x81;
static uint8_t ep_out_addr =3D 0x02;
static bool endpoints_enabled;
static bool configuration_done;
static bool packet_sent;
static int connect_count;
static int disconnect_count;
static volatile sig_atomic_t stop_requested;

static void on_signal(int signo)
{
(void)signo;
stop_requested =3D 1;
}

static void print_hex(const char *label, const uint8_t *buf, size_t len)
{
size_t i;

fprintf(stderr, "%s (%zu bytes):", label, len);
for (i =3D 0; i < len; ++i)
fprintf(stderr, " %02x", buf[i]);
fprintf(stderr, "\n");
}

static int do_ioctl(unsigned long request, void *arg, const char *what)
{
int ret =3D ioctl(raw_fd, request, arg);

if (ret < 0)
fprintf(stderr, "%s failed: %s\n", what, strerror(errno));
return ret;
}

static int ep0_io(unsigned long request, uint8_t *buf, size_t len)
{
struct usb_raw_ep_io *io;
size_t total =3D sizeof(*io) + len;
int ret;

io =3D calloc(1, total);
if (!io)
return -ENOMEM;
io->length =3D len;
if (request =3D=3D USB_RAW_IOCTL_EP0_WRITE && len)
memcpy(io->data, buf, len);

ret =3D ioctl(raw_fd, request, io);
if (ret < 0) {
ret =3D -errno;
fprintf(stderr, "ep0 ioctl 0x%lx failed: %s\n",
request, strerror(errno));
goto out;
}
if (request =3D=3D USB_RAW_IOCTL_EP0_READ && ret > 0 && buf)
memcpy(buf, io->data, ret);
out:
free(io);
return ret;
}

static int ep_io(unsigned long request, uint16_t handle, uint8_t *buf,
size_t len)
{
struct usb_raw_ep_io *io;
size_t total =3D sizeof(*io) + len;
int ret;

io =3D calloc(1, total);
if (!io)
return -ENOMEM;
io->ep =3D handle;
io->length =3D len;
if (request =3D=3D USB_RAW_IOCTL_EP_WRITE && len)
memcpy(io->data, buf, len);

ret =3D ioctl(raw_fd, request, io);
if (ret < 0) {
ret =3D -errno;
fprintf(stderr, "ep ioctl 0x%lx handle %u failed: %s\n",
request, handle, strerror(errno));
goto out;
}
out:
free(io);
return ret;
}

static int ep0_write_bytes(const void *buf, size_t len)
{
return ep0_io(USB_RAW_IOCTL_EP0_WRITE, (uint8_t *)buf, len);
}

static int ep0_read_bytes(uint8_t *buf, size_t len)
{
return ep0_io(USB_RAW_IOCTL_EP0_READ, buf, len);
}

static int ep_write_bytes(uint16_t handle, const void *buf, size_t len)
{
return ep_io(USB_RAW_IOCTL_EP_WRITE, handle, (uint8_t *)buf, len);
}

static int ep0_stall(void)
{
if (ioctl(raw_fd, USB_RAW_IOCTL_EP0_STALL, 0) < 0) {
fprintf(stderr, "ep0 stall failed: %s\n", strerror(errno));
return -errno;
}
return 0;
}

static size_t build_string_descriptor(const char *ascii, uint8_t *out,
size_t out_len)
{
size_t ascii_len =3D strlen(ascii);
size_t needed =3D 2 + ascii_len * 2;
size_t i;

if (out_len < needed)
return 0;

out[0] =3D needed;
out[1] =3D USB_DT_STRING;
for (i =3D 0; i < ascii_len; ++i) {
out[2 + i * 2] =3D (uint8_t)ascii[i];
out[3 + i * 2] =3D 0;
}

return needed;
}

static void choose_endpoints(void)
{
struct usb_raw_eps_info info;
int count;
int i;
bool any_in =3D false;
bool any_out =3D false;

memset(&info, 0, sizeof(info));
count =3D do_ioctl(USB_RAW_IOCTL_EPS_INFO, &info, "USB_RAW_IOCTL_EPS_INFO")=
;
if (count < 0)
exit(1);

fprintf(stderr, "raw gadget reports %d endpoints\n", count);
for (i =3D 0; i < count && i < USB_RAW_EPS_NUM_MAX; ++i) {
char name[USB_RAW_EP_NAME_MAX + 1];
struct usb_raw_ep_info *ep =3D &info.eps[i];

memcpy(name, ep->name, USB_RAW_EP_NAME_MAX);
name[USB_RAW_EP_NAME_MAX] =3D '\0';
fprintf(stderr,
"  ep[%d] name=3D%s addr=3D0x%02x int=3D%u in=3D%u out=3D%u maxpacket=3D%u\=
n",
i, name, ep->addr, ep->caps.type_int, ep->caps.dir_in,
ep->caps.dir_out, ep->limits.maxpacket_limit);

if (ep->caps.type_int && ep->caps.dir_in) {
if (ep->addr =3D=3D USB_RAW_EP_ADDR_ANY)
any_in =3D true;
else if (!any_in && ep_in_addr =3D=3D 0x81)
ep_in_addr =3D ep->addr;
}
if (ep->caps.type_int && ep->caps.dir_out) {
if (ep->addr =3D=3D USB_RAW_EP_ADDR_ANY)
any_out =3D true;
else if (!any_out && ep_out_addr =3D=3D 0x02)
ep_out_addr =3D ep->addr;
}
}

if (any_in)
ep_in_addr =3D 0x81;
if (any_out)
ep_out_addr =3D 0x02;

fprintf(stderr, "using interrupt endpoints in=3D0x%02x out=3D0x%02x\n",
ep_in_addr, ep_out_addr);
}

static struct descriptor_block make_config_block(void)
{
struct descriptor_block block;

memset(&block, 0, sizeof(block));

block.config.bLength =3D sizeof(block.config);
block.config.bDescriptorType =3D USB_DT_CONFIG;
block.config.wTotalLength =3D htole16(sizeof(block));
block.config.bNumInterfaces =3D 1;
block.config.bConfigurationValue =3D CONFIG_VALUE;
block.config.bmAttributes =3D USB_CONFIG_ATT_ONE;
block.config.bMaxPower =3D 1;

block.intf.bLength =3D sizeof(block.intf);
block.intf.bDescriptorType =3D USB_DT_INTERFACE;
block.intf.bInterfaceNumber =3D 0;
block.intf.bAlternateSetting =3D 0;
block.intf.bNumEndpoints =3D 2;
block.intf.bInterfaceClass =3D USB_CLASS_VENDOR_SPEC;
block.intf.bInterfaceSubClass =3D 0;
block.intf.bInterfaceProtocol =3D 0;

block.ep_in.bLength =3D sizeof(block.ep_in);
block.ep_in.bDescriptorType =3D USB_DT_ENDPOINT;
block.ep_in.bEndpointAddress =3D ep_in_addr;
block.ep_in.bmAttributes =3D USB_ENDPOINT_XFER_INT;
block.ep_in.wMaxPacketSize =3D htole16(IN_MAX_PACKET);
block.ep_in.bInterval =3D 1;

block.ep_out.bLength =3D sizeof(block.ep_out);
block.ep_out.bDescriptorType =3D USB_DT_ENDPOINT;
block.ep_out.bEndpointAddress =3D ep_out_addr;
block.ep_out.bmAttributes =3D USB_ENDPOINT_XFER_INT;
block.ep_out.wMaxPacketSize =3D htole16(OUT_MAX_PACKET);
block.ep_out.bInterval =3D 1;

return block;
}

static int ensure_endpoints_enabled(void)
{
struct descriptor_block block =3D make_config_block();

if (endpoints_enabled)
return 0;

ep_in_handle =3D ioctl(raw_fd, USB_RAW_IOCTL_EP_ENABLE, &block.ep_in);
if (ep_in_handle < 0) {
fprintf(stderr, "enable IN endpoint failed: %s\n", strerror(errno));
return -errno;
}

ep_out_handle =3D ioctl(raw_fd, USB_RAW_IOCTL_EP_ENABLE, &block.ep_out);
if (ep_out_handle < 0) {
fprintf(stderr, "enable OUT endpoint failed: %s\n", strerror(errno));
return -errno;
}

if (ioctl(raw_fd, USB_RAW_IOCTL_CONFIGURE, 0) < 0) {
fprintf(stderr, "USB_RAW_IOCTL_CONFIGURE failed: %s\n",
strerror(errno));
return -errno;
}

endpoints_enabled =3D true;
fprintf(stderr,
"configured endpoints: in_handle=3D%d out_handle=3D%d in_addr=3D0x%02x
out_addr=3D0x%02x\n",
ep_in_handle, ep_out_handle, ep_in_addr, ep_out_addr);

return 0;
}

static int handle_get_descriptor(uint16_t value, uint16_t length)
{
uint8_t desc_type =3D value >> 8;
uint8_t desc_index =3D value & 0xff;
uint8_t buffer[256];
size_t send_len =3D 0;
struct usb_device_descriptor device =3D {
.bLength =3D USB_DT_DEVICE_SIZE,
.bDescriptorType =3D USB_DT_DEVICE,
.bcdUSB =3D htole16(0x0200),
.bDeviceClass =3D USB_CLASS_PER_INTERFACE,
.bDeviceSubClass =3D 0,
.bDeviceProtocol =3D 0,
.bMaxPacketSize0 =3D 64,
.idVendor =3D htole16(VENDOR_ID),
.idProduct =3D htole16(PRODUCT_ID),
.bcdDevice =3D htole16(0x0001),
.iManufacturer =3D 1,
.iProduct =3D 2,
.iSerialNumber =3D 3,
.bNumConfigurations =3D 1,
};
struct descriptor_block config =3D make_config_block();

memset(buffer, 0, sizeof(buffer));

switch (desc_type) {
case USB_DT_DEVICE:
memcpy(buffer, &device, sizeof(device));
send_len =3D sizeof(device);
break;
case USB_DT_CONFIG:
memcpy(buffer, &config, sizeof(config));
send_len =3D sizeof(config);
break;
case USB_DT_STRING:
if (desc_index =3D=3D 0) {
buffer[0] =3D 4;
buffer[1] =3D USB_DT_STRING;
buffer[2] =3D 0x09;
buffer[3] =3D 0x04;
send_len =3D 4;
} else if (desc_index =3D=3D 1) {
send_len =3D build_string_descriptor("raw-gadget", buffer,
sizeof(buffer));
} else if (desc_index =3D=3D 2) {
send_len =3D build_string_descriptor("Earthmate short-header test",
buffer, sizeof(buffer));
} else if (desc_index =3D=3D 3) {
send_len =3D build_string_descriptor("test-001", buffer,
sizeof(buffer));
}
break;
default:
fprintf(stderr, "stalling unsupported descriptor type 0x%02x index %u\n",
desc_type, desc_index);
return ep0_stall();
}

if (send_len =3D=3D 0)
return ep0_stall();

if (length < send_len)
send_len =3D length;

print_hex("ep0 descriptor reply", buffer, send_len);
return ep0_write_bytes(buffer, send_len);
}

static int handle_standard_request(const struct usb_ctrlrequest *ctrl)
{
uint16_t value =3D le16toh(ctrl->wValue);
uint16_t index =3D le16toh(ctrl->wIndex);
uint16_t length =3D le16toh(ctrl->wLength);
uint8_t status[2] =3D { 0, 0 };
uint8_t alt =3D 0;

switch (ctrl->bRequest) {
case USB_REQ_GET_DESCRIPTOR:
return handle_get_descriptor(value, length);
case USB_REQ_SET_ADDRESS:
fprintf(stderr, "ack SET_ADDRESS %u\n", value);
return ep0_read_bytes(NULL, 0);
case USB_REQ_SET_CONFIGURATION:
fprintf(stderr, "SET_CONFIGURATION %u\n", value);
if (value =3D=3D CONFIG_VALUE) {
int ret;

ret =3D ep0_read_bytes(NULL, 0);
if (ret < 0)
return ret;
ret =3D ensure_endpoints_enabled();
if (ret < 0)
return ret;
configuration_done =3D true;
return 0;
}
return ep0_read_bytes(NULL, 0);
case USB_REQ_GET_CONFIGURATION: {
uint8_t current_config =3D value;

(void)current_config;
current_config =3D configuration_done ? CONFIG_VALUE : 0;
return ep0_write_bytes(&current_config, sizeof(current_config));
}
case USB_REQ_GET_STATUS:
return ep0_write_bytes(status, sizeof(status));
case USB_REQ_SET_INTERFACE:
fprintf(stderr, "SET_INTERFACE index=3D%u alt=3D%u\n", index, value);
return ep0_read_bytes(NULL, 0);
case USB_REQ_GET_INTERFACE:
return ep0_write_bytes(&alt, sizeof(alt));
case USB_REQ_CLEAR_FEATURE:
case USB_REQ_SET_FEATURE:
fprintf(stderr, "ack feature request req=3D0x%02x value=3D0x%04x index=3D0x=
%04x\n",
ctrl->bRequest, value, index);
return ep0_read_bytes(NULL, 0);
default:
fprintf(stderr, "stalling unsupported standard request 0x%02x\n",
ctrl->bRequest);
return ep0_stall();
}
}

static int send_short_interrupt_packet(void)
{
uint8_t payload[1] =3D { 0 };
int ret;

if (packet_sent)
return 0;
if (!configuration_done || ep_in_handle < 0)
return -EINVAL;

fprintf(stderr,
"queueing 1-byte interrupt-in transfer: handle=3D%d addr=3D0x%02x maxpacket=
=3D%u\n",
ep_in_handle, ep_in_addr, IN_MAX_PACKET);
ret =3D ep_write_bytes(ep_in_handle, payload, sizeof(payload));
if (ret < 0)
return ret;

packet_sent =3D true;
fprintf(stderr, "interrupt-in transfer completed with %d byte(s)\n", ret);
return ret;
}

static int handle_class_request(const struct usb_ctrlrequest *ctrl)
{
uint16_t length =3D le16toh(ctrl->wLength);
uint8_t *buffer;
int ret;

buffer =3D calloc(1, length ? length : 1);
if (!buffer)
return -ENOMEM;

switch (ctrl->bRequest) {
case SET_REPORT:
ret =3D ep0_read_bytes(buffer, length);
if (ret >=3D 0) {
print_hex("SET_REPORT payload", buffer, ret);
ret =3D send_short_interrupt_packet();
if (ret >=3D 0)
ret =3D 0;
}
free(buffer);
return ret;
case GET_REPORT:
memset(buffer, 0, length);
print_hex("GET_REPORT reply", buffer, length);
ret =3D ep0_write_bytes(buffer, length);
free(buffer);
return ret;
default:
fprintf(stderr, "stalling unsupported class request 0x%02x\n",
ctrl->bRequest);
free(buffer);
return ep0_stall();
}
}

static int handle_control_event(const struct usb_ctrlrequest *ctrl)
{
fprintf(stderr,
"control request type=3D0x%02x req=3D0x%02x value=3D0x%04x index=3D0x%04x l=
en=3D%u\n",
ctrl->bRequestType, ctrl->bRequest, le16toh(ctrl->wValue),
le16toh(ctrl->wIndex), le16toh(ctrl->wLength));

switch (ctrl->bRequestType & USB_TYPE_MASK) {
case USB_TYPE_STANDARD:
return handle_standard_request(ctrl);
case USB_TYPE_CLASS:
return handle_class_request(ctrl);
default:
fprintf(stderr, "stalling request with unsupported type mask 0x%02x\n",
ctrl->bRequestType & USB_TYPE_MASK);
return ep0_stall();
}
}

int main(void)
{
struct usb_raw_init init;
struct {
struct usb_raw_event event;
uint8_t data[256];
} event_buf;

signal(SIGINT, on_signal);
signal(SIGTERM, on_signal);
signal(SIGALRM, on_signal);
alarm(75);

raw_fd =3D open("/dev/raw-gadget", O_RDWR);
if (raw_fd < 0) {
perror("open /dev/raw-gadget");
return 1;
}

memset(&init, 0, sizeof(init));
memcpy(init.driver_name, "dummy_udc", sizeof("dummy_udc"));
memcpy(init.device_name, "dummy_udc.0", sizeof("dummy_udc.0"));
init.speed =3D USB_SPEED_FULL;

if (do_ioctl(USB_RAW_IOCTL_INIT, &init, "USB_RAW_IOCTL_INIT") < 0)
return 1;
if (do_ioctl(USB_RAW_IOCTL_RUN, NULL, "USB_RAW_IOCTL_RUN") < 0)
return 1;

fprintf(stderr,
"raw gadget started on dummy_udc.0 for VID:PID %04x:%04x\n",
VENDOR_ID, PRODUCT_ID);

while (!stop_requested) {
struct usb_ctrlrequest ctrl;
int ret;

memset(&event_buf, 0, sizeof(event_buf));
event_buf.event.length =3D sizeof(event_buf.data);
ret =3D ioctl(raw_fd, USB_RAW_IOCTL_EVENT_FETCH, &event_buf);
if (ret < 0) {
if (errno =3D=3D EINTR && stop_requested)
break;
perror("USB_RAW_IOCTL_EVENT_FETCH");
return 1;
}

switch (event_buf.event.type) {
case USB_RAW_EVENT_CONNECT:
connect_count++;
fprintf(stderr, "received CONNECT event #%d\n", connect_count);
choose_endpoints();
break;
case USB_RAW_EVENT_CONTROL:
if (event_buf.event.length !=3D sizeof(ctrl)) {
fprintf(stderr,
"unexpected control payload size %u\n",
event_buf.event.length);
return 1;
}
memcpy(&ctrl, event_buf.data, sizeof(ctrl));
ret =3D handle_control_event(&ctrl);
if (ret < 0) {
fprintf(stderr, "control handling failed: %d\n", ret);
return 1;
}
if (packet_sent) {
fprintf(stderr, "packet sent; waiting briefly for follow-up events\n");
sleep(2);
return 0;
}
break;
case USB_RAW_EVENT_RESET:
fprintf(stderr, "received RESET event\n");
break;
case USB_RAW_EVENT_DISCONNECT:
disconnect_count++;
fprintf(stderr, "received DISCONNECT event #%d\n", disconnect_count);
if (packet_sent)
return 0;
if (disconnect_count >=3D 4)
return 1;
break;
case USB_RAW_EVENT_SUSPEND:
fprintf(stderr, "received SUSPEND event\n");
break;
case USB_RAW_EVENT_RESUME:
fprintf(stderr, "received RESUME event\n");
break;
default:
fprintf(stderr, "received event type %u\n", event_buf.event.type);
break;
}
}

fprintf(stderr, "stop requested before packet was sent\n");
return packet_sent ? 0 : 1;
}

---- end reproducer ----

Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B45=E6=
=9C=8822=E6=97=A5=E5=91=A8=E4=BA=94 19:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 22, 2026 at 12:16:21PM +0200, Johan Hovold wrote:
> > Make sure that the interrupt-out endpoint max packet size is at least
> > eight bytes to avoid user-controlled slab corruption or NULL-pointer
> > dereference should a malicious device report a smaller size.
> >
> > Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from c=
haracteristic size")
> > Cc: stable@vger.kernel.org    # 2.6.26
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/serial/cypress_m8.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypre=
ss_m8.c
> > index afff1a0f4298..82ba0900b399 100644
> > --- a/drivers/usb/serial/cypress_m8.c
> > +++ b/drivers/usb/serial/cypress_m8.c
> > @@ -445,6 +445,14 @@ static int cypress_generic_port_probe(struct usb_s=
erial_port *port)
> >               return -ENODEV;
> >       }
> >
> > +     /*
> > +      * The buffer must be large enough for the one or two-byte header=
 (and
> > +      * following data) but assume anything smaller than eight bytes i=
s
> > +      * broken.
> > +      */
> > +     if (port->interrupt_out_size < 8)
> > +             return -EINVAL;
> > +
> >       priv =3D kzalloc_obj(struct cypress_private);
> >       if (!priv)
> >               return -ENOMEM;
> > --
> > 2.53.0
> >
> >
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Johan Hovold <johan@kernel.org> =E4=BA=8E2026=E5=B9=B45=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=BA=94 18:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Make sure that the interrupt-out endpoint max packet size is at least
> eight bytes to avoid user-controlled slab corruption or NULL-pointer
> dereference should a malicious device report a smaller size.
>
> Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from cha=
racteristic size")
> Cc: stable@vger.kernel.org      # 2.6.26
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/cypress_m8.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress=
_m8.c
> index afff1a0f4298..82ba0900b399 100644
> --- a/drivers/usb/serial/cypress_m8.c
> +++ b/drivers/usb/serial/cypress_m8.c
> @@ -445,6 +445,14 @@ static int cypress_generic_port_probe(struct usb_ser=
ial_port *port)
>                 return -ENODEV;
>         }
>
> +       /*
> +        * The buffer must be large enough for the one or two-byte header=
 (and
> +        * following data) but assume anything smaller than eight bytes i=
s
> +        * broken.
> +        */
> +       if (port->interrupt_out_size < 8)
> +               return -EINVAL;
> +
>         priv =3D kzalloc_obj(struct cypress_private);
>         if (!priv)
>                 return -ENOMEM;
> --
> 2.53.0
>

